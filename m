Message-ID: <4E76FADB.6040204@domain.hid>
Date: Mon, 19 Sep 2011 10:18:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E76DB36.5060203@domain.hid>
	<21788_1316418497_4E76F3C1_21788_13255_1_ECB646CBB62FD044927FDEDF0252D3E701E39310098B@THSONEA01CMS03P.one.grp>
In-Reply-To: <21788_1316418497_4E76F3C1_21788_13255_1_ECB646CBB62FD044927FDEDF0252D3E701E39310098B@THSONEA01CMS03P.one.grp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Can a network freeze caused by Xenomai ?
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
Cc: Xenomai help <xenomai@xenomai.org>

On 2011-09-19 09:49, VEYSSIERE Nicolas wrote:
> Hello,
> 
> I would like to know if it is possible that a network freeze been caused by the use of Xenomai ?
> 
> Here is my problem : we have 4 HP DL 360 G6 server. All are installed with the last update of Redhat Entreprise Linux 5.6.
> 
> All 4 have 4 physical ethernet interface (2 from intel chipset, 2 from broadcom chipset).
> 
> They all have a virtual ethernet interface on eth0 (named eth0:1).
> 
> 2 of them have Xenomai installed (v2.5.5.2 with linux kernel v2.6.35.7).

2.6.35 may lack ipipe fixes we have in the latest versions now. So
updating this and the Xenomai release should be the first step.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

