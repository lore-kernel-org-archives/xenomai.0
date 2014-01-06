Message-ID: <52CB232C.1050009@xenomai.org>
Date: Mon, 06 Jan 2014 22:42:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
 <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
 <52CB0B6A.8080405@xenomai.org>
 <CAFnctWGxXWKL2bdnf4s-Xubw2jGe249uSXim9oqLbiSPqxeXFA@mail.gmail.com>
 <52CB1F67.1080909@xenomai.org>
 <CAFnctWGi6cSxDUWN5e3qSbCHFumW7T6_f9XGwWW_Nr+Drj7=Xw@mail.gmail.com>
In-Reply-To: <CAFnctWGi6cSxDUWN5e3qSbCHFumW7T6_f9XGwWW_Nr+Drj7=Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nima Nourozi <n.nourozi@gmail.com>
Cc: xenomai@xenomai.org

On 01/06/2014 10:40 PM, Nima Nourozi wrote:
> [<c00250a0>] (do_undefinstr+0x0/0x1f0) from [<c002ac74>]
> (__und_svc+0x54/0x80)

The problem is do_undefinstr, which usually indicates a bug whether
intentional (using the BUG macro) or not. The rest are false positive
due to the debug checks happening during the handling of this bug.

-- 
                                                                Gilles.

