References: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
 <56BB9BE5.80505@xenomai.org>
 <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BDBA3D.9080901@xenomai.org>
Date: Fri, 12 Feb 2016 11:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Process shared rt_event_wait() never signaled on ARM
 with Mercury core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 02/11/2016 01:57 PM, Charles Kiorpes wrote:
> will be trying combinations of kernels and configuration options
> throughout the course of the day.
>  

The embedded-specific options in the kernel configuration
(CONFIG_EMBEDDED) should be checked, particularly CONFIG_FUTEX.

-- 
Philippe.

