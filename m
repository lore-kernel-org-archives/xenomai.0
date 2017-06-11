MIME-Version: 1.0
From: Jim Langston <jim.langston@gmail.com>
Date: Sun, 11 Jun 2017 10:02:54 -0400
Message-ID: <CAF06wtgG4OQ3ya2XkOx6B9gGAXrQpPT0xm2WQ9VvEoCvnxHR3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Migrating 2.x projects to 3.x...
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have been attempting to port over a project building using a quite old
version of Xenomai (2.4.10 on kernel 2.6.30.5) to 3.x on kernel 4.1.18.

I have read through the Migration guide, and have made the following
changes based on what I saw needed changing:

- Removed all references to 'native/intr.h', since that doesn't exist any
more
- 'T_PRIMARY' flag for 'rt_task_set_mode()' doesn't exist, so replace with
'T_CONFORMING'
- In the makefiles, pass '--native --compat' to 'xeno-config'

This seems to make everything build and link with a minimum of fuss, no
undefined items, link errors, etc.

Unfortunately, for my applications that connect to drivers, I get the
following:


*front_panel.c:144:10: warning: implicit declaration of function
=E2=80=98rt_dev_ioctl=E2=80=99 [-Wimplicit-function-declaration]*
I get this for basically all functions starting with 'rt_dev_'.  There is a
mention of it in the Migration Guide.

So my question is:  Do I need to manually replace all calls to 'rt_dev_'
with 'rt_' calls, or is my compatibility library not being linked in
properly?

Thanks,
Jim
