Message-ID: <4E030D1D.5080406@domain.hid>
Date: Thu, 23 Jun 2011 11:53:33 +0200
From: varname <varname@domain.hid>
MIME-Version: 1.0
References: <18303_1308739447_4E01C777_18303_558_1_ECB646CBB62FD044927FDEDF0252D3E701E388B3612E@THSONEA01CMS03P.one.grp>	<4E01CA9A.2040709@domain.hid>	<17296_1308741006_4E01CD8E_17296_18611_1_ECB646CBB62FD044927FDEDF0252D3E701E388B361AA@THSONEA01CMS03P.one.grp>	<4E01CE25.2020202@domain.hid>	<17288_1308741885_4E01D0FD_17288_343_1_ECB646CBB62FD044927FDEDF0252D3E701E388B36206@domain.hid>	<4E01E0EE.90002@domain.hid>	<18303_1308746837_4E01E455_18303_6972_2_ECB646CBB62FD044927FDEDF0252D3E701E388B3645B@THSONEA01CMS03P.one.grp>	<4E01E62D.8050504@domain.hid>
	<18217_1308821465_4E0307D9_18217_13108_1_ECB646CBB62FD044927FDEDF0252D3E701E388B85F94@domain.hid>
In-Reply-To: <18217_1308821465_4E0307D9_18217_13108_1_ECB646CBB62FD044927FDEDF0252D3E701E388B85F94@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic on boot with 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

VEYSSIERE Nicolas wrote:
> Found the problem !
> 
> It works on an Intel E5400 processor (for the host) but not on an Intel E2140

So what was the problem? Looking at [1], I guess support for VT-x?



[1] http://ark.intel.com/Compare.aspx?ids=29738,40478,

