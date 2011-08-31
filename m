Message-ID: <4E5DDED0.8070806@domain.hid>
Date: Wed, 31 Aug 2011 09:12:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E5DDB3D.8020804@domain.hid>
In-Reply-To: <4E5DDB3D.8020804@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] do rt_task_create after a deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 08/31/2011 08:57 AM, Roberto Bielli wrote:
> Hi,
> 
> if i don't want to use rt_task_join to wait termination on a task,

Then do not create the task with the T_JOINABLE flag.

> is it 
> correct to use rt_task_create and wait until the return value is 
> different from -EEXIST after a deletion?

I am not sure rt_task_create returns EEXIST when a task has been deleted
but not joined. But in any case, the answer is no, a joinable task will
not be joined automatically, only rt_task_join will cause it to be joined.

-- 
					    Gilles.

