Message-ID: <45ABB43B.6010804@domain.hid>
Date: Mon, 15 Jan 2007 18:04:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] IPIPE for ARM9 i.MX and AT91RM9200 ?
References: <45AB9D58.3060308@domain.hid> <45ABA0C7.3050407@domain.hid>
	<45ABA6E4.3030707@domain.hid> <45ABA91F.909@domain.hid>
	<45ABA9FC.7070606@domain.hid>
In-Reply-To: <45ABA9FC.7070606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

Steven Scholz wrote:
> Ok. Thanks.
> 
> IIUC then 2.6.15 was before the introduction of the generic irq layer.
> 
> So would these make it easier to port to a newer kernel? Or harder?
> 
> Steven

I have not delved into the details of the 2.6.19 yet, but I would tend
to think that the genirq layer will only improve the genericity of the
I-pipe code on the long run.

Since Philippe has done the x86 port of Adeos on 2.6.19, he will
probably be able to comment more on that.

-- 
                                                 Gilles Chanteperdrix

