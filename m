From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
References: <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid>
Date: Wed, 06 Apr 2011 20:33:08 +0200
Message-Id: <20110406183309.028D5151F83@domain.hid>
Subject: Re: [Xenomai-core] Backfire: User <-> Kernel latancy mesurement
	tool on Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna m <krishnamurthyjs@domain.hid>
Cc: xenomai@xenomai.org

Dear krishna m,

In message <COL122-W4082C3BC356937E8C1DDADBDA50@domain.hid> you wrote:
> 
> * is there any similar tool like backfire in the Xenomai tool set that dose
>  the similar measurements?

We use (and recommend) the "gpioirqbench" benchmark. See the
application note for it here:
http://www.denx.de/wiki/DULG/AN2008_03_Xenomai_gpioirqbench

Note that this works with both Xenomai and PREEMPT_RT.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
The man on tops walks a lonely street;  the  "chain"  of  command  is
often a noose.

