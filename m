From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=w67oJVc+iwJdN3znbje0PMiEcjtEUic3xMcNj@domain.hid>
References: <AANLkTi=w67oJVc+iwJdN3znbje0PMiEcjtEUic3xMcNj@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 Jan 2011 09:56:57 +0100
Message-ID: <1295341017.1857.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] segfault sharing mutex from kernel space to user
 space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2011-01-17 at 14:15 -0600, Jeff Weber wrote:
> I get a segfault when attempting to rt_mutex_acquire a mutex created
> in kernel space.  I've reduced the issue to the following sample code.
> Help finding my mistake is appreciated.

[snip]

> int main(void)
> {
>     RT_MUTEX mtx;
>     RT_TASK  tsk;
>     RT_MUTEX_INFO info;

Could you move the RT_MUTEX_INFO buffer to global scope and try again?
TIA,

-- 
Philippe.



