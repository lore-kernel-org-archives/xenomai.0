From: Steven Seeger <steven.seeger@nasa.gov>
Date: Wed, 4 Apr 2018 11:25:14 -0400
Message-ID: <1542961.KC98kqrEBl@wirbelwind>
In-Reply-To: <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
 <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wednesday, April 4, 2018 8:57:31 AM EDT Sagi Maimon wrote:
> HI,
> I did it only from Linux side.
> I can try doing it from xenomai side too.
> Please explain how would it help to investigate the problem?
>

If the problem does not occur in a regular linux thread, but only occurs in a 
xenomai-scheduled thread, then it drastically narrows down where the problem 
might be. Plus, you get a further test if you upgrade yuor kernel and ipipe 
patch.

Steven




