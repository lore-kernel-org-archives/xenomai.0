Message-ID: <4B95208D.7020809@domain.hid>
Date: Mon, 08 Mar 2010 17:06:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid>
	<4B90F2D3.8020508@domain.hid>	<4B91290C.7070005@domain.hid>
	<4B9131B4.6060105@domain.hid>	<4B913C71.4060006@domain.hid>
	<4B914107.3000108@domain.hid>	<4B9222D1.1000207@domain.hid>
	<4B924586.1060400@domain.hid>
In-Reply-To: <4B924586.1060400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH v2] Allow for deregistering current
 mode user space address
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
>> I think my workflow was misleading regarding this. Not necessarily all
>> stuff I push into my 'for-upstream' branch is done with all tests at the
>> time when I push. Official pull request mails are supposed to mark this.
>> I'm pushing to save my work and, of course, to expose it. So I
>> appreciate comments, but I surely don't expect them within minutes.
> 
> No. You still refuse to acknowledge the truth: I receive pull requests
> for untested stuff. Read John's mail again. He cherry picked changes,
> for which I received a pull request, he ran the mutex-torture tests,
> which the patchset had modified, and the test was not passing. So, the
> conclusion is that you did not run mutex-torture, which the commit had
> modified before sending the pull request. I did not have to dig long in
> the git logs to find this example. It was just yesterday. Think about it.
> 
> That is precisely the situation I want to avoid from now on.

Ok. It turns out that yes, the timed mutex tests had a bug, but probably
only visible on uniprocessor machines. And I guess you test on SMP
machines. So, my apologies, the patch was tested, not enough, but tested.

>> PS: Note that this u_mode fix exposed an issue of the sigtest:
>> cancel_with_signals fails if there is some TSD destructor registered
>> that issues a Xenomai syscall. Not sure yet if it is a fundamental issue
>> or just related to the test itself.
> 
> The sigtest test probably assumes that no parasite syscall occurs. Yet
> another reason for not using this u_mode implementation.

Remove that test case. I do not know what it was testing anyway.

-- 
					    Gilles.

