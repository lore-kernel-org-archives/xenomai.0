From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17355.48657.408322.647457@domain.hid>
Date: Mon, 16 Jan 2006 16:38:57 +0100
Subject: Re: [Xenomai-core] anonymous user-space tasks (again)
In-Reply-To: <17355.32872.996051.514072@domain.hid>
References: <200601152002.36397.kisda@domain.hid>
	<17355.32872.996051.514072@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > Stefan Kisdaroczi wrote:
 >  > A small program only calling rt_task_shadow with NULL-name fails if i start it 
 >  > a second time. Error EEXIST (-17). Same for a program calling only 
 >  > rt_task_spawn with NULL-name.
 > 
 > I am able to observe this behaviour. I am on it.

It is fixed in svn trunk.

-- 


					    Gilles Chanteperdrix.

