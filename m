Message-ID: <51FF8F1D.6010002@xenomai.org>
Date: Mon, 05 Aug 2013 13:40:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0DE90633-1CDC-4BB5-837D-D9FA5409B73D@imag.fr>
In-Reply-To: <0DE90633-1CDC-4BB5-837D-D9FA5409B73D@imag.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] polling task and rt_task_sleep()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Skander Bahloul <skander.bahloul@imag.fr>
Cc: xenomai@xenomai.org

On 08/01/2013 06:20 PM, Skander Bahloul wrote:
> Dear Xenomai list members,
> 
> I'am trying to use xenomai for a polling task.
> 
> I'am use rt_task_sleep() and i discover that this function is
> important to execute the program but it causes latencies.
> 
> If i delete this function, the terminal freeze.

Hi,

good! it means xenomai works as expected: your polling task has the
highest priority and prevent anything else from running.

Regards.

-- 
                                                                Gilles.

