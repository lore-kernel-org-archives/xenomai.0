Message-ID: <4DAD4ADA.4040007@domain.hid>
Date: Tue, 19 Apr 2011 10:42:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid>	<1302268379.2101.35.camel@domain.hid>	<4DA30C80.3010107@domain.hid>	<1302531493.2054.355.camel@domain.hid>	<4DA30E14.6070401@domain.hid>	<1302532049.2054.357.camel@domain.hid>	<4DA31108.9080000@domain.hid>	<1302532753.2054	<4DA314F1.3070504@domain.hid>	<4DA31EB6.4040909@domain.hid>
	<4DA4544F.7020300@domain.hid>	<4DA45660.4000003@domain.hid>
	<4DA45D0F.4090501@domain.hid>	<4DA45E42.5030500@domain.hid>
	<4DA45FD7.9000802@domain.hid>	<4DAD392D.7030501@domain.hid>
	<1303198745.2096.8.camel@domain.hid>	<4DAD40B7.5000803@domain.hid>
	<1303200143.2096.11.camel@domain.hid>
In-Reply-To: <1303200143.2096.11.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Tue, 2011-04-19 at 09:58 +0200, Jesper Christensen wrote:
>> Great thanks, but i can't help wondering if the problems i'm seeing are
>> related to some of my userspace programs using fp.
> 
> I don't think so. The switchtest programs exercises the FPU hardware in
> a certain way to make sure it is available in real-time mode from kernel
> space (which is an utterly crappy legacy, but we will have to deal with
> it until Xenomai 3.x). As far as I can see from your .config, you can't
> have such support, so switchtest was basically trying to test an
> inexistent feature.

In fact, switchtest whether Xenomai FPU switch routines work when the
Linux kernel itself uses FPU in kernel-space. Currently, the only place
when this happens is in the RAID code: x86 uses mmx/sse, and some power
pcs use altivec. Some powerpc also fix unaligned accesses to floating
point data in kernel-space, I do not know if this may interfere, which
is why the powerpc code is compiled even without RAID.


-- 
					    Gilles.

