Message-ID: <5541FD72.3090806@xenomai.org>
Date: Thu, 30 Apr 2015 12:01:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
In-Reply-To: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org
Cc: martin.bielik.sk@gmail.com

On 04/30/2015 10:14 AM, Ronny Meeus wrote:
> Hello
> 
> we are using the xenomai-forge mercury core together with the pSOS interface.
> 
> We observe following issue: we have 3 tasks at different priorities
> (see test code attached).
> The task with the middle priority is running forever (while (1)).
> 
> The higest prio task is responsible cleaning up the 2 other tasks.
> If the middle prio task is deleted first, followed by the low prio, it works.
> If the low prio task is deleted first, the high prio task just blocks
> on the delete and the system hangs in that phase.
> 

I could not reproduce this bug with your test case unmodified after an
hour running this program in loop. Could you paste the output of
--dump-config so that I can align on your settings?

> My assumption is that this is a bug in the delete functionality.
> Is this a known issue?
> 

No report from such issue.

-- 
Philippe.

