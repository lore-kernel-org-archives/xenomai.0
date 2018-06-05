From: Steven Seeger <steven.seeger@nasa.gov>
Date: Tue, 5 Jun 2018 09:33:21 -0400
Message-ID: <8802987.z5JkY3iLTf@wirbelwind>
In-Reply-To: <035ed079-cdbb-c39f-d3c6-2a0f46f59361@xenomai.org>
References: <035ed079-cdbb-c39f-d3c6-2a0f46f59361@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Introducing Dovetail
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On Tuesday, June 5, 2018 6:48:23 AM EDT Philippe Gerum wrote:
> This is a heads-up about an ongoing work I hinted at last year [1]
> codenamed "Dovetail", which has just reached a significant milestone. In
>  short, an overhauled implementation of the interrupt pipeline is now
> capable of delivering short response times reliably on the ARM SoCs I'm
> working on (mainly i.MX(6q|7d) so far), running the recent 4.17 kernel
> release.

<snip>

Hi Philippe.

Looks like there is just one branch here. Assuming this is the future, is the 
goal here to have a generic branch and arch-specific branches again?

Steven



