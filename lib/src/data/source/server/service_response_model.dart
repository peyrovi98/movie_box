class ServiceResponseModel<T> {
  late bool status;
  late String message;
  int? statusCode;
  late T data;

  ServiceResponseModel(this.status, this.message, this.data,
      {this.statusCode = 200});
}
