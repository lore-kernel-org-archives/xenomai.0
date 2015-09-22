References: <5601617F.3080800@sigmatek.at> <56016225.5090601@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5601A1A1.2020506@siemens.com>
Date: Tue, 22 Sep 2015 20:44:49 +0200
MIME-Version: 1.0
In-Reply-To: <56016225.5090601@sigmatek.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem that the Linux scheduler is not called for
	some ms
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wolfgang.netbal@sigmatek.at, Xenomai Mailing List <xenomai@xenomai.org>

On 2015-09-22 16:13, Wolfgang Netbal wrote:
> 
> 
> Hi guys
> 
> I have a problem that the linux scheduler is not called for some ms.
> The cpu load is very low.
> 
> Im using a iMX6, linux kernel 3.0.42 and xenomai 2.6.2.1.
> 
> I have attached a graphical task trace where you can see the task switches.
> The tasks with prefix X- are xenomai task, the prefix L- means linux task.
> In the first line you can see the tick from a fpga to start the folowing
> tasks, X-realtime, X-cyclic, X-Loader and X-background.
> The X-Cyclic task is switching to linux (L-Cyclic) in each cycle because
> it is calling UDP functions.
> Up the mark 195 ms everthing is working correct.
>  From the mark 195 ms up to 199 ms there is no linux task (L-) running.
> I have also seen that the linux scheduler function is not called from
> the mark 195ms to 199ms.
> 
> Does anybody know what is the problem ?
> Are there some linux/xenomai settings to modify this behavior ?

As you already recorded (f)traces, just dive deeper and check why some
of the Linux tasks are blocked, ie. when they go to sleep, check the
reason. And then, when they wake up again, check who woke them up and
via which mechanism. Maybe that will provide some trace to what goes wrong.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

