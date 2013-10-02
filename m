MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
Date: Wed, 2 Oct 2013 13:42:35 +0200
Message-ID: <CAAXf6LUfHA9aHe2FRngFJSKVXeKPVwxGLcRPYGNBqd7U1dMzKg@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] xenomai-forge: multiple COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

The (L)GPL requires that every distribution of a derived work is
accompanied with the license of the program (xenomai-forge).
Currently, xenomai-forge contains several COPYING files:

./kernel/cobalt/nucleus/COPYING
./kernel/cobalt/COPYING
./kernel/cobalt/rtdm/COPYING
./include/COPYING
./lib/alchemy/COPYING
./lib/psos/COPYING
./lib/vxworks/COPYING
./lib/analogy/COPYING
./lib/cobalt/COPYING
./lib/copperplate/COPYING

An embedded build system like buildroot [1] has legal-info facilities
to mark for each package which license it uses, and where the license
files is located. A user can easily generate an overview of the
license information for all packages used in the system, and contains
almost everything necessary to comply with the (L)GPL. In buildroot,
this is done with 'make legal-info'.

In the case of buildroot, the license files are copied one by one in a
directory named after the package. This would essentially mean:
cp <xenomai-source>/kernel/cobalt/nucleus/COPYING licenses/xenomai/COPYING
cp <xenomai-source>/kernel/cobalt/COPYING licenses/xenomai/COPYING
cp <xenomai-source>/kernel/cobalt/rtdm/COPYING licenses/xenomai/COPYING
...

Clearly, the fact that all license files have the same name poses a
problem here. In order to have all files, one would either need to
rename them, or duplicate the directory structure.

Instead of moving this complexity outside of xenomai-forge (to the
build system), I would like to discuss how it can be solved within
xenomai-forge itself.

Here are two proposals:
1. Is it really necessary that there are multiple COPYING files? Is it
not possible to have one COPYING file in the root of the project, and
move the exception specified in include/COPYING to that file? This
approach is similar to many many other open-source projects.

2. Alternatively, what about renaming the license files to a unique
name, e.g. COPYING.alchemy, COPYING.psos, COPYING.cobalt-nucleus ?
Then, copying these files to one directory is possible without overwriting.

Thanks,
Thomas

[1] http://buildroot.org

