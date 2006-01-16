From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17355.32872.996051.514072@domain.hid>
Date: Mon, 16 Jan 2006 12:15:52 +0100
Subject: Re: [Xenomai-core] anonymous user-space tasks (again)
In-Reply-To: <200601152002.36397.kisda@domain.hid>
References: <200601152002.36397.kisda@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
 > A small program only calling rt_task_shadow with NULL-name fails if i start it 
 > a second time. Error EEXIST (-17). Same for a program calling only 
 > rt_task_spawn with NULL-name.

I am able to observe this behaviour. I am on it.

 > Apropos registry:
 > In the trunk there is no file src/native/registry.c anymore. I do not really 
 > miss it, but the API documentation still says these calls can be made from 
 > user-space. Should I create a patch to update the docs? Or should it be 
 > there?

I will update the doc too. There are no registry syscalls in
ksrc/skins/native/syscall.c, and no skins/native/lib/registry.c in 2.0.x
branch either, so it looks intentional. Registry services are not
accessible from user-space. Philippe will be able to explain here.

Thanks for reporting.

-- 


					    Gilles Chanteperdrix.

