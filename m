Message-ID: <4E36BB3B.60308@domain.hid>
Date: Mon, 01 Aug 2011 16:42:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E367A11.3050001@domain.hid>
In-Reply-To: <4E367A11.3050001@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_suspend,
 rt_task_delete chooses wrong tasks
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

On 08/01/2011 12:04 PM, Roberto Bielli wrote:
> Hi,
> 
> i see a big problem in xenomai. Aftear a certain number of task deletion 
> (rt_task_delete) and re-create task
> the RT_TASK descriptors that i have in my application don't match with 
> the correct task.

Could you show us the code which initializes the rtDesc member of the
structure, in order to allow us reproducing your scenario?

-- 
					    Gilles.

