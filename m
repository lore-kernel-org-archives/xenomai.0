Message-ID: <acf4207114cc324d0b7001985eade534d6e3c4be.camel@sprinte.eu>
Subject: Re: having problems with daemonizing
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Mon, 29 Apr 2019 09:12:37 +0200
In-Reply-To: <5CC38412.8030107@freyder.net>
References: <44ftq4zcr9.fsf@be-well.ilk.org> <5CC38412.8030107@freyder.net>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Freyder <steve@freyder.net>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

Le vendredi 26 avril 2019 à 17:20 -0500, Steve Freyder via Xenomai a
écrit :
> 
> I can tell you that I have a hang issue due to fork() in a Xenomai
> program if, after the fork(), I don't do an exec().  I believe
> the hang is related to registry access, and the fact that the
> Unix domain socket connecting to sysregd that is inherited by
> the forked process (which has FD_CLOEXEC set) hasn't yet gotten
> closed (no exec() yet so no action on FD_CLOEXEC flags yet).

We ran into a similar issue (still using 3.0.5, which seems not to have
the FD_CLOEXEC flag set).

If you don’t share any file descriptors with the child process, the
following (after the fork and before the exec) did help in our case :

DIR* dirs = opendir("/proc/self/fd");
int fd = dirfd(dirs);
dirent* d = readdir(dirs);
while (d != nullptr)
{
	int a = 0;
	a = std::strtol(d->d_name, nullptr, 10);
	if (errno == 0 && a > 2 && a != fd)
	{
		close(a);
	}
	d = readdir(dirs);
}
closedir(dirs);

Basically it closes any open file descriptor by the child process,
except stdout/stderr.

Note that we are forking from a linux domain thread hosted in a xenomai
application, creating a pure linux application. In that case the
registry stuff is complete nonsense in the child process. But this
should also be ok for other use cases.

Regards,

Julien


