References: <CAGTNcBtzrhyCvWycQGo+G_gyDjK17jWCGudszBNgF1Uv=9pmcA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <722e8501-1ba7-39f1-9ba2-78b82ed43683@xenomai.org>
Date: Sat, 1 Apr 2017 11:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAGTNcBtzrhyCvWycQGo+G_gyDjK17jWCGudszBNgF1Uv=9pmcA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency.c: fix occasional SIGSEGV at shutdown when
 mode is USER_TASK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Bowman <jbowman@facts-inc.com>, xenomai@xenomai.org

On 04/01/2017 08:25 AM, Josh Bowman wrote:
> Hi,
> 
> Under Mercury, I've been seeing occasionally a "Segmentation fault" message
> when I hit ctrl-c to stop the latency test program. I caught a core dump,
> and the stack trace leads back to the sem_wait() call in the display task.
> 
> I think this is caused by the cleanup() routine destroying the semaphore
> before it calls join on the display task. This patch seems to fix the issue.
> 

Good catch. Merged, thanks.

-- 
Philippe.

