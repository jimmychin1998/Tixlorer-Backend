using Microsoft.EntityFrameworkCore;
using TixlorerCore.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<TixplorerContext>(
    option => option.UseSqlServer(builder.Configuration.GetConnectionString("TixplorerConnection"))
    );
//�[�Jsession�ϥήM��
builder.Services.AddSession();
builder.Services.AddDbContext<TixplorerContext>();
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseSession(); //�ϥ�session�\��
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
