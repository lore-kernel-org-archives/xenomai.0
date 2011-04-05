From: Robert Berger <gmane@domain.hid>
Date: Tue, 05 Apr 2011 21:36:25 +0300
Message-ID: <infnf9$6jm$1@domain.hid>
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>	<infaa9$eoe$1@domain.hid>
	<4D9B4EC0.5080701@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <4D9B4EC0.5080701@domain.hid>
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
Reply-To: gmane@domain.hid
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi Gilles,

On 04/05/2011 08:17 PM, Gilles Chanteperdrix wrote:
> 
> Ok, we are on Xenomai-core, so, let us discuss. If we admit that the OP
> is indeed talking about latencies (a quantifiable measure of
> determinism), suggesting that the effect on cache of the Linux kernel
> might influence the latencies is not completely irrelevant: the
> benchmark we make with Xenomai tend to consistently show that cache
> thrashing by the Linux kernel has an effect on latencies.

Yes this did not immediately come into my mind. Linux cache thrashing
affects latencies of threads running under Xenomai (user and/or kernel
space), but as you point out (
http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/8167 )
that is distro independent.

I know that the answer to this question might not be trivial, but what
would you suggest could be done to minimize cache thrashing?

> 
> Also, having shorter latencies means that we cover a larger range of
> user-application needs. So, we try to have short latencies.
> 

Whoever wants to see Xenomai latencies in action can compile cyclictest
with and without Xenomai and see the differences. On the platforms I've
tried so far the differences are clearly visible;)

Regards,

Robert
...Never test for an error condition you don't know how to handle.

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



