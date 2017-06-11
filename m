References: <CAF06wtgG4OQ3ya2XkOx6B9gGAXrQpPT0xm2WQ9VvEoCvnxHR3Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2d1d8708-2af0-9624-bd51-66cf78575f1f@xenomai.org>
Date: Sun, 11 Jun 2017 17:57:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAF06wtgG4OQ3ya2XkOx6B9gGAXrQpPT0xm2WQ9VvEoCvnxHR3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Migrating 2.x projects to 3.x...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jlangston@panurgyinc.com, xenomai@xenomai.org

On 06/11/2017 04:02 PM, Jim Langston wrote:
> Hello,
> 
> I have been attempting to port over a project building using a quite old
> version of Xenomai (2.4.10 on kernel 2.6.30.5) to 3.x on kernel 4.1.18.
> 
> I have read through the Migration guide, and have made the following
> changes based on what I saw needed changing:
> 
> - Removed all references to 'native/intr.h', since that doesn't exist any
> more
> - 'T_PRIMARY' flag for 'rt_task_set_mode()' doesn't exist, so replace with
> 'T_CONFORMING'
> - In the makefiles, pass '--native --compat' to 'xeno-config'
> 
> This seems to make everything build and link with a minimum of fuss, no
> undefined items, link errors, etc.
> 
> Unfortunately, for my applications that connect to drivers, I get the
> following:
> 
> 
> *front_panel.c:144:10: warning: implicit declaration of function
> ‘rt_dev_ioctl’ [-Wimplicit-function-declaration]*
> I get this for basically all functions starting with 'rt_dev_'.  There is a
> mention of it in the Migration Guide.
> 
> So my question is:  Do I need to manually replace all calls to 'rt_dev_'
> with 'rt_' calls, or is my compatibility library not being linked in
> properly?
> 

You have three options:

1. convert the rt_dev* calls to their POSIX counterpart as provided by
libcobalt. Assuming you don't use the symbol wrapping [1], you would
need to explicitly pull the libcobalt symbols, e.g. __RT(ioctl(...)) for
replacing calls to rt_dev_ioctl(). If you do wrap the symbols, then
calling ioctl() would be enough.

2. enable the compat layer (aka libtrank), by passing the --compat flag
to xeno-config. This would cause compat definitions and code to be
interposed when building, including the obsolete rt_dev* API.

3. hack away by directly pulling include/trank/rtdm/rtdm.h, which
defines what you need.

The reasoning behind this change is that Xenomai 3 bases everything on
libcobalt's POSIX implementation in dual kernel mode, so adding yet
another interface such as rt_dev* only to wrap names became useless noise.

[1]
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/#Under_the_hood_the_8211wrap_flag

-- 
Philippe.

