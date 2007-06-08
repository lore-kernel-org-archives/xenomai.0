Message-ID: <466950AC.4050602@domain.hid>
Date: Fri, 08 Jun 2007 14:50:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <403B28AE6257B548B66BB88414AC78330174BC33@domain.hid>
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC33@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] AT91 patch duplicated code ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

BOUIN Alexandre wrote:
>       Gilles asked for some people to test
>       adeos-ipipe-2.6.20-arm-1.7-03.patch. As we said, our board are
>       always ready to receive new releases.
> 
>       Once 2.6.20 kernel unpacked, I've started patching it with
>       Xenomai, including last release of Adeos patch. I've kept last
>       releases of our libs cause nothing seems block us to use them with
>       a new kernel. Our Buildroot is using glibc and kernel has no debug
>       traces.

If you did not do it recompile Xenomai kernel-space from trunk or branch
v2.3.x svn. The new patch can not work with older kernel-space support.

-- 
                                                 Gilles Chanteperdrix

