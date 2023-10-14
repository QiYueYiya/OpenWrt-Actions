m = Map("autoua2f", translate("UA2F"))
m.description = translate([[
        <span style="font-family: '微软雅黑'; color: pink">该界面由 Brukamen 开发</span><br>
        <span style="font-family: '微软雅黑'; color: pink">联系邮箱：169296793@qq.com</span><br>
        <span style="font-family: '微软雅黑'; color: pink">点击按钮启用或关闭相应功能，转到测试网址测试结果为Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36 Edg/112.0.1722.68则成功开启防检测</span><br>
        <span style="font-family: '微软雅黑'; color: red">该插件并非适合所有类型的检测！！！</span><br>
        <span style="font-family: '微软雅黑'; color: yellow"><a href="http://ua.233996.xyz/" target="_blank">点击此处跳转到测试网址</a></span>
    ]])
    
m:section(SimpleSection).template = "ua2f/ua2f"

e = m:section(TypedSection, "autoua2f", translate(""))
e.addremove = false
e.anonymous = true

o1 = e:option(Flag, "enabled", translate("启用/开机自启"))
o1.rmempty = false

o2 = e:option(Flag, "handle_fw", translate("自动配置防火墙"), translate("是否自动添加防火墙规则"))
o2.rmempty = false


o3 = e:option(Flag, "handle_intranet", translate("处理内网流量"), translate("是否处理内网流量，如果你的路由器是在内网中，且你想要处理内网中的流量，那么请启用这一选项"))
o3.rmempty = false

o4 = e:option(Flag, "handle_tls", translate("处理443端口流量"), translate("通常来说，流经 443 端口的流量是加密的，因此无需处理"))
o4.rmempty = false

o5 = e:option(Flag, "handle_mmtls", translate("处理微信流量"), translate("微信的流量通常是加密的，因此无需处理，这一规则在启用 nftables 时无效"))
o5.rmempty = false

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/autoua2f start")
end

return m
