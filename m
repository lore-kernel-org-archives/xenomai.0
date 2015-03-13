Message-ID: <55030F78.3040300@siemens.com>
Date: Fri, 13 Mar 2015 17:25:28 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54EEF08B.6040905@triphase.com>	<20150226102010.GA24003@hermes.click-hack.org>	<54EF0790.3040607@triphase.com>	<54F07AC2.6000902@triphase.com>	<54F0D46F.1070006@siemens.com>	<54F56C9C.6080507@siemens.com>
 <CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>
 <54FDB495.3060303@triphase.com> <5501FC89.2040205@siemens.com>
In-Reply-To: <5501FC89.2040205@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Niels Wellens <niels.wellens@triphase.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-03-12 21:52, Jan Kiszka wrote:
> I finally started some tests here as well with your config, but I don't
> expect results soon (if at all), given your long times to reproduce
> things. 

As expected, the issue refuses to show up here so far.

> I will also make some new patches available soon that target
> very specific corner cases in kernel exception handling. However, these
> patches will apply to both 3.16 and 3.14, so nothing that could easily
> explain your issues.

Those patches are now available at
http://git.xenomai.org/ipipe-jki.git/log/?h=for-upstream/master. Maybe
we are lucky and the change something on your side. Please give them a try.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

