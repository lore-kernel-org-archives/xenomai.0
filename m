References: <20160215174121.GA10070@deathstar>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <56C2B626.8010804@sigmatek.at>
Date: Tue, 16 Feb 2016 06:39:50 +0100
MIME-Version: 1.0
In-Reply-To: <20160215174121.GA10070@deathstar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT serial cross-link failure
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai-bounces@xenomai.org, xenomai@xenomai.org



Am 2016-02-15 um 18:41 schrieb Michael Welling:
> I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.
>
> The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.
>
> When I run the cross-link demo the system hangs after an error in read_task.
>
> Here is the output that I get:
> main : write-file opened
> main : write-config written
> main : read-file opened
> main : read-config written
> main : write-task created
> main : read-task created
> main : starting write-task
> main : strating read-task
>   Nr |   write-irq    |    irq->read    |   write->read   |
> ----------------------------------------------------------
> read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
> main : /dev/rtdm/rtser1 (read) -> closed
> read_task: exit
>
> Any ideas why this would happen?
>
> I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.
Dear Michael,

I added a patch on December where I extended the IMX UART driver to 
support open firmware, maybe my patch can help you to find your issue.
I posted the patch in the mailing list, you can find it here 
https://xenomai.org/pipermail/xenomai/2015-December/035655.html

Kind regards
Wolfgang
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>


