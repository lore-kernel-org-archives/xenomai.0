Sender: dv@domain.hid
Message-ID: <45043DD7.5A317C85@domain.hid>
Date: Sun, 10 Sep 2006 18:31:19 +0200
From: Detlef Vollmann <dv@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on PXA
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
	<17618.12042.631648.702921@domain.hid>
	<1154703176.9602.26.camel@domain.hid>
	<17631.9753.589322.882530@domain.hid>
	<4503D322.1E88D034@domain.hid>
	<17668.739.465406.379629@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Detlef Vollmann wrote:
>  > With that change, first tests look fine.
> 
> Thanks, attached the patch with this error corrected.
Thanks.

>  > BTW, on the SA, what results do you get from xeno-test?
> 
> latency in user-space easily get above 100 microseconds, if this is what
> you mean. But I guess this is what we should expect on ARM.
Probably yes.  The histogram just looks a bit strange, nearly
all in the last column...

Another point: did you run the switchbench test?

With '-n 100000' I get a sure softlock.

 Detlef

-- 
Detlef Vollmann   vollmann engineering gmbh
Linux and C++ for Embedded Systems    http://www.vollmann.ch/
Linux for PXA270 Colibri module: http://www.vollmann.ch/en/colibri/

