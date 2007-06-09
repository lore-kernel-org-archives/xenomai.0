MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18026.38832.965291.874125@domain.hid>
Date: Sat, 9 Jun 2007 14:06:08 +0200
In-Reply-To: <305035a40706081335v5d49fde2i96dd8b2b0a22fb50@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC34@domain.hid>
	<18025.37833.610273.790254@domain.hid>
	<305035a40706081335v5d49fde2i96dd8b2b0a22fb50@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Adeos-main]  AT91 patch duplicated code ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

Gregory CLEMENT wrote:
 > 2007/6/8, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
 > > BOUIN Alexandre wrote:
 > >  >
 > >  > > When we released our last version of adeos-ipipe-2.6.19-arm-AT91.patch, we suggested to merge code for at91rm9200 and at91sam926x.
 > >  > > These 2 code are split but quite similar, so we think it could be a good idea. Are you OK for removing duplicated code ?
 > >
 > > If I have to choose between duplicating some Linux code in I-pipe code
 > > and have some duplication in the I-pipe patch, I choose duplication in
 > > the I-pipe patch. If you duplicate Linux code, you will have to avoid
 > > forgetting to update this duplicate code when Linux code evolves.
 > >
 > 
 > Well the first mail wasn't very clear. I am going to explain what we
 > have in mind.
 > 
 > In Linux code for AT91 timer there are two files: at91sam926x_time.c
 > and at91rm9200_time.c because AT91RM9200 and AT91SAM926x have
 > different system timer: AT91RM9200 use AT91_ST peripheral and
 > AT91SAM926x use AT91_PIT peripheral.

I was somehow thinking that there was something else in at91xx_time.c
than what is enclosed in #ifdef CONFIG_IPIPE. I was wrong.

Now, I have another question: is there no way to use the AT91_PIT
peripheral in one shot mode ? What is the resolution of this PIT ?

In any case, please send a patch, this will make a real base for
discussion.

-- 


					    Gilles Chanteperdrix.

