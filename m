Message-ID: <50F48DBF.7030207@xenomai.org>
Date: Mon, 14 Jan 2013 23:59:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADyNBOqpGW510ZdcQAukgsEBzfQsoq3u_BqNDSM0No3C65w5+g@mail.gmail.com>
In-Reply-To: <CADyNBOqpGW510ZdcQAukgsEBzfQsoq3u_BqNDSM0No3C65w5+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amit Bhaira <a.hearthacker.b@gmail.com>
Cc: xenomai@xenomai.org

On 01/14/2013 11:41 PM, Amit Bhaira wrote:

> what would happen if I use rt_task_create API in a user space non rt task??


Nothing extraordinary, as mentioned in rt_task_create documentation any
user-space task is valid to call rt_task_create.

-- 
                                                                Gilles.

