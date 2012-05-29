Message-ID: <4FC4CBC6.3030409@xenomai.org>
Date: Tue, 29 May 2012 15:14:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfO26_v+gQnMnu9_dkWMMQ3D7WCB_PxXa6tsSYNFEnBdQ@mail.gmail.com>
In-Reply-To: <CAKKWdtfO26_v+gQnMnu9_dkWMMQ3D7WCB_PxXa6tsSYNFEnBdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] What is the Xenomai time limit?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenoma <xenomai@xenomai.org>

On 05/29/2012 02:54 PM, ali hagigat wrote:
> We know that Xenomai can create hard real time tasks and it means that
> the real time tasks will be executed up to a specific time. My
> question is about that time. How much is that time?(100 micro seconds,
> 150 usec, or...)
> I know that it may depend on the architecture and the software platform.
> I want to know how can i determine that time for my x86 32-bit PC
> system? and besides what major factors are effecting the time?
> Any answer will be much appreciated.
> Is it OK to ask such general questions in this mailing list or i
> should use the other mailing list, xenomai@xenomai.org?
> Thank you Mr. Chanteperdrix to answer my previous question.

There is no such time limit. A task is executed as long as it does not
suspend or yield and there is no other task with higher priority.

Please note: the mailing list address changed, it is now xenomai@xenomai.org

-- 
					    Gilles.

