param ercircuitname string
param asn int
param primaryPeerAddressPrefix string
param secondaryPeerAddressPrefix string
param provider string = 'Megaport'
param peeringlocation string
param bandwidthInMbps int
param sku string = 'Standard'

var location = resourceGroup().location

resource ercircuit 'Microsoft.Network/expressRouteCircuits@2021-03-01' = {
  name: ercircuitname
  location: location
  sku: {
    name: '${sku}_MeteredData'
    tier: sku
    family: 'MeteredData'
  }
  properties: {
    peerings: [
      {
        name: 'AzurePrivatePeering'
        properties: {
          peeringType: 'AzurePrivatePeering'
          peerASN: asn
          primaryPeerAddressPrefix: primaryPeerAddressPrefix
          secondaryPeerAddressPrefix: secondaryPeerAddressPrefix
          state: 'Enabled'
          vlanId: 100          
        }
      }
    ]
    serviceProviderProperties: {
      serviceProviderName: provider
      peeringLocation: peeringlocation
      bandwidthInMbps: bandwidthInMbps
    }
  }
}

output ErCircuitOutput string = ercircuitname
output ErServiceKey string = ercircuit.properties.serviceKey
