References: <CAOuPNLjjqZgqzwRe5ACxdPiCUpedbEW4Xh3FU=gSZc9tMmdgjw@mail.gmail.com>
 <5f063f66-df76-f7d4-c01e-aa7baadf3420@xenomai.org>
 <CAOuPNLhDXu3+igc7dKCWUxp1uy=1KzCXorr1gWmtjY=3ZrL4ig@mail.gmail.com>
 <78df92df-7f8b-c439-ce1c-732068e91ff3@xenomai.org>
 <CAOuPNLitA++hLqwGqU6+SN3mhhAfgOzfpyEd0XR4CvU_ykT7fg@mail.gmail.com>
 <b43d4638-51a6-e583-e138-c1c8317f669b@xenomai.org>
 <CAOuPNLgVyd45-vG9CF7vYnCxQ4ksf-O52etQe1iHUhSjG-HuxA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <35565a5e-7e26-a419-715c-323dbdb13ba6@xenomai.org>
Date: Fri, 16 Mar 2018 10:25:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLgVyd45-vG9CF7vYnCxQ4ksf-O52etQe1iHUhSjG-HuxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] segmentation fault during rt_task_unblock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/15/2018 05:47 PM, Pintu Kumar wrote:
> Hi,
> 
> Please find the complete program below:

Thanks. This is a Xenomai bug, most likely in libcopperplate. What your
test app tries to do is legit. The bug also triggers in native mode
(Mercury), so this is a generic issue. I'll follow up on this.

-- 
Philippe.

