From: Steven Seeger <steven.seeger@nasa.gov>
Date: Wed, 4 Apr 2018 13:16:59 -0400
Message-ID: <80155073.HUEqfJo2pc@wirbelwind>
In-Reply-To: <cad2a4c9f8b749109afff86f3ef0f201@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <1542961.KC98kqrEBl@wirbelwind>
 <cad2a4c9f8b749109afff86f3ef0f201@advaoptical.com>
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

On Wednesday, April 4, 2018 11:42:08 AM EDT Sagi Maimon wrote:
> Thanks for your reply.
> You are right, but unfortunately in my ssytem it happens on the Linux side:
> The Linux kernel code that fixes the alignment during align exception (600)
> works most of the time, but sometimes during the alignment fix 
> "Unrecoverable FP Unavailable Exception" occurs. My suspicion is that the
> xenomai still holds the FPU, but I not familiar enough with the xenomi
> code.
> 
> Any how I still trying to make it occur on the xenomai side.

Narrow it down to a simple few lines that cause the error, and put it in a 
shadowed xenomai thread and see if the error still occurs. This will help 
eliminate the possibility of any xenomai/linux interaction. Of course, you can 
just put all your energy into testing with an upgraded kernel and xenomai, 
too.

Steven




