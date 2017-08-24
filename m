Date: Thu, 24 Aug 2017 17:59:52 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170824175952.7f7a0984@md1em3qc>
In-Reply-To: <CAMcKmiHUHPdgg0avFpz+RWi4r6gFDNXdLtOT2vQu1VchnkHs8w@mail.gmail.com>
References: <CAMcKmiHUHPdgg0avFpz+RWi4r6gFDNXdLtOT2vQu1VchnkHs8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] undefined symbol __wrap_malloc in 3.0.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>
Cc: xenomai@xenomai.org

If you are indeed on *untu you might want to read that
https://www.ubuntu.com/legal/terms-and-policies/intellectual-property-policy
And the section "Any redistribution of modified versions of Ubuntu must
be approved, certified or provided by Canonical if ....".

I am not a lawyer but give that information to your lawyer if you are
considering using *untu in products.

regards,
Henning

Am Thu, 24 Aug 2017 08:38:29 -0700
schrieb George Broz <brozgeo@gmail.com>:

> Hi ,
> 
> I am trying to run an application in Xenomai 3.0.4 that was
> previously running fine in Xenomai 3.0.2.
> 
> On startup of the application, I get the message:
> ./my_app: symbol lookup error: ./my_app: undefined symbol:
> __wrap_malloc
> 
> (which terminates the application.)
> 
> I noticed that malloc and free are missing from the cobalt.wrappers
> in 3.0.4. They are now in "modechk.wrappers"
> 
> I saw that a xeno-config option was added
> (--no-mode-check/--mode-check) . I have added this to my link flags
> for the application. I have tried both options
> and I still get the same undefined symbol message on startup.
> 
> Can someone please tell me how I can build the application to now find
> these wrappers? Does it require a Xenomai kernel configuration option
> to be selected as well?
> 
> 
> Thanks in advance!
> 
> --George Broz
> Moog Industrial Group
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


