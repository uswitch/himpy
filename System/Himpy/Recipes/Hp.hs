module System.Himpy.Recipes.Hp where
import System.Himpy.Recipes.Utils
import System.Himpy.Mib
import System.Himpy.Types
import System.Himpy.Logger
import System.Himpy.Output.Riemann
import System.Himpy.Index
import Control.Concurrent.STM.TChan (TChan)

hasMetric :: ((String,String), Maybe Double) -> Bool
hasMetric ((_,_), Nothing) = False
hasMetric ((_, _), (Just _)) = True

buildMetric ((host,service), (Just metric)) =
  Metric host service "ok" metric

hp_rcp :: TChan ([Metric]) -> TChan (String) -> Integer -> HimpyHost -> HIndex -> IO ()
hp_rcp chan logchan ival (Host host comm _) index = do
  names <- snmp_walk_str host comm ifName
  opstatus <- snmp_walk_num host comm ifOperStatus

  rx <- snmp_walk_num host comm ifInOctets
  tx <- snmp_walk_num host comm ifOutOctets

  in_discards <- snmp_walk_num host comm ifInDiscards
  out_discards <- snmp_walk_num host comm ifOutDiscards
  in_errors <- snmp_walk_num host comm ifInErrors
  out_errors <- snmp_walk_num host comm ifOutErrors

  ip_addresses <- snmp_walk_oid_ip host comm ipNetToMediaNetAddress
  mac_addresses <- snmp_walk_oid_str host comm ipNetToMediaPhysAddress

  mac_addresses <- snmp_walk_oid_str host comm dot1dTpFdbPort
  mac_address_ports <- snmp_walk_oid_int host comm dot1dBasePortIfIndex

  conn <- snmp_walk_num host comm ifConnectorPresent
  adminstatus <- snmp_walk_num host comm ifAdminStatus

  let mtrs =  concat [snmp_metrics host "opstatus" $ zip names opstatus,
                      snmp_metrics host "in_octets" $ zip names rx,
                      snmp_metrics host "out_octets" $ zip names tx,
                      snmp_metrics host "conn" $ zip names conn,
                      snmp_metrics host "in_discards" $ zip names in_discards,
                      snmp_metrics host "out_discards" $ zip names out_discards,
                      snmp_metrics host "in_errors" $ zip names in_errors,
                      snmp_metrics host "out_errors" $ zip names out_errors,
                      snmp_metrics host "adminstatus" $ zip names adminstatus]
  riemann_send chan mtrs
