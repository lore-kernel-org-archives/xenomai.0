Date: Tue, 12 Dec 2017 13:22:34 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171212132234.56efb9aa@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <61d0fbdd-e513-ac68-9e61-a11ea75da557@xenomai.org>
References: <61d0fbdd-e513-ac68-9e61-a11ea75da557@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Remove support for PowerPC64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Am Mon, 11 Dec 2017 19:55:25 +0100
schrieb Philippe Gerum <rpm@xenomai.org>:

> PPC64 is a non-trivial port to maintain (mostly regarding the
> interrupt pipeline). However, the Xenomai user base for this
> architecture has always been very small, not to say marginal.
> 
> As part of the ongoing effort to fit the project to the resources, I
> would suggest to drop support for the PowerPC64 architecture, in the
> same terms than it just happened with Blackfin, i.e.
> 
> - The I-pipe support for the ppc64 architecture would not be
> maintained beyond kernel 4.9.51 (LTS).
> 
> - ppc64 support would be marked as deprecated in the next releases of
> the Xenomai 3.0.x series, then no more maintained from that point (not
> even build tested). This code would be fully removed from the -next
> branch leading to Xenomai 3.1.
> 
> Please send any feedback before Jan 15, 2018.

No objections from my side.

Henning

> Thanks,
> 


