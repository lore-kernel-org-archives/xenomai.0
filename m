Message-ID: <BLU436-SMTP2549CFA8208C1D85905494AF0190@phx.gbl>
References: <BLU436-SMTP5068DD4CFCAD34C1CC29DDF0190@phx.gbl>
 <565047BC.2010101@xenomai.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sat, 21 Nov 2015 08:30:09 -0800
MIME-Version: 1.0
In-Reply-To: <565047BC.2010101@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] registry
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 15-11-21 02:30 AM, Philippe Gerum wrote:
> On 11/21/2015 06:53 AM, Mathieu Rondonneau wrote:
>> Hi,
>>
>> When a skin (lets say vxworks for example) does a
>> registry_add_dir("/vxworks"), where this directory gets created?
>>
>> I can see the registry as follow:
>> /var/run/xenomai/root/
>> /var/run/xenomai/system/heaps
>> /var/run/xenomai/system/threads
>> /var/run/xenomai/system/version
>>
>> This is how I started the registry:
>> sudo ./sysregd --linger --daemonize --anon --root=/var/run/xenomai
>>
>> so I was expecting to be able to find a directory as follow:
>> /var/run/xenomai/anon/<pid>/vxworks
> 
> Nope. A registry spawned manually from the command line is supposed to
> manage a session shared between several application processes. --anon is
> an internal switch used by copperplate aimed at starting a private
> session for the current process, when it does not want to share anything
> with other processes. You should not use this switch directly.
> 
> --root should be the path of the top directory for the session, so
> /var/run/xenomai won't work since this is the default root for all sessions.
> 
Thanks Philippe, it looks like I don't need to start sysregd manually then.

>>
>> >From my test app, I have tried to find the directory in those locations
>> with no luck:
>> /var/run/xenomai/<pid>/vxworks
>> /var/run/xenomai/vxworks
> 
> If starting the sysregd daemon is left to copperplate, that would be:
> 
> /var/run/xenomai/<user>/<session-label>/<pid>/vxworks
> 
> When the session is anonymous, <session-label> is "anon@<pid>".
> 
> If you start the daemon manually from the command line, --root should
> specify the session directory, and the vxworks tree below would be
> located at:
> 
> <session-top-dir>/vxworks
> 
it looks like the path I need to look for is:
/var/run/xenomai/<user>/<session-label>/<pid>/vxworks

>>
>> Now I think I am missing a setup somewhere.
>>
> 
> lib/{alchemy,psos,vxworks}/init.c illustrate this. --enable-registry
> should be passed to the configure script.
> 
I have this flag set already.

