
export default function toStringCurrency(value) {
  if (isNaN(value)) {
    return '';
  }

  const formatter = new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL',
    minimumFractionDigits: 0
  });
  return formatter.format(value);
}
