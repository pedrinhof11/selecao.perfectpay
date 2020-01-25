export default function convertStatus(status) {
  const acceptedStatus = {
    SOLD: () => 'Vendidos',
    CANCELED: () => 'Cancelados',
    DEVOLUTION: () => 'Devoluções'
  }
  return acceptedStatus[status]();
}
