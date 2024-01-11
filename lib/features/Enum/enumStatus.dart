enum BookingStatus{
  Pending('معلق'),
  Completed('مكتمل'),
  Cinfirmed('مؤكد'),
  Rejected('مرفوض'),
  Canceled('ملغى');
  const BookingStatus(this.value);
  final String value;
}