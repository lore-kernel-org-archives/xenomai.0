Message-ID: <5178F16B.504@xenomai.org>
Date: Thu, 25 Apr 2013 11:03:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
	<51778082.4060504@xenomai.org>
	<CAH8NBSfP3ToQtYMFZymuPwB_E96q=7wBWsL_Ag2r2c=dSwa6yA@mail.gmail.com>
	<51779EF1.6010801@xenomai.org>
	<CAH8NBSfmRw8mGdH4Fo10bxCHP4YTpCcNkXDg_AFxxArQ7we6wA@mail.gmail.com>
	<CAH8NBSeCvBMAzGK8ewUvDW2TY4GYDzZSW8EF20+WyKFoMB2V0Q@mail.gmail.com>
In-Reply-To: <CAH8NBSeCvBMAzGK8ewUvDW2TY4GYDzZSW8EF20+WyKFoMB2V0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Srikanth C <srikanthc9@gmail.com>
Cc: Xenomai@xenomai.org

On 04/25/2013 09:57 AM, Srikanth C wrote:
> Test Results with adeos-ipipe patch:
>
> H/W Setup is same, S/W Changed to adeos-ipipe with 3.0.8 kernel.
>
> adeos-ipipe-3.0.8-powerpc-2.13-04.patch applied to 3.0.8 kernel,
> spurious interrupt is not raised with this patch.
>

I still don't know what ppc platform you are running on, which does not 
allow me to figure out which interrupt controller might be involved, and 
how to try reproducing this issue.

Again and I won't ask for this once more:

- what is your ppc platform: 40x, 44x, 52xx, 82xx, 83xx, 85xx, 86xx, 
anything else?

> All ipipe series patches raising spurious interrupt in powerpc.
>

The few patches > 3.0.8 you tried on your own PCI setup and kernel 
configuration raise spurious interrupts on your own board, would be a 
more informative way to describe the situation.

-- 
Philippe.

