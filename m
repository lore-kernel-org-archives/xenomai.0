Date: Tue, 4 Dec 2018 07:55:52 -0600 (CST)
From: Per Oberg <pero@wolfram.com>
Message-ID: <460522296.16134757.1543931752769.JavaMail.zimbra@wolfram.com>
Subject: Re: HelloWorld with CMake
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>
Cc: Evandro Sestrem <sestrem@gmail.com>

----- Den 4 dec 2018, p=C3=A5 kl 12:40, xenomai xenomai@xenomai.org skrev:=
=20

> Hello,=20

Hi,=20

I accindently posted my answer directly to Evandro. So for completeness I i=
nclude Xenomai list.=20
You have some answers already, however my Xenomai 2 vs 3 comment was not me=
ntioned earlier.=20

> Is it possible to use CMake to compile a Xenomai program?=20

Yes, I use CMake for compilation. I have found that a lot of examples out t=
here needs Xenomai 2 and does not work with Xenomai 3.=20

You may have a look at https://github.com/iocroblab/xenomai-cmake which i f=
ound worked quite well.=20


> I want to use Xenomai in a ROS 2 node. To do this, I need to be able to=
=20
> compile it with CMake.=20

> I'm trying to compile a HelloWorld Xenomai program using CMake.=20

> I put this project in https://github.com/sestrem/xenomai_helloworld_cmake=
=20

> The main files are:=20
> helloWorld.c=20
> CMakeLists.txt=20

> When I execute "cmake .", everything is fine:=20

> -- The C compiler identification is GNU 6.3.0=20
> -- The CXX compiler identification is GNU 6.3.0=20
> -- Check for working C compiler: /usr/bin/cc=20
> -- Check for working C compiler: /usr/bin/cc -- works=20
> -- Detecting C compiler ABI info=20
> -- Detecting C compiler ABI info - done=20
> -- Detecting C compile features=20
> -- Detecting C compile features - done=20
> -- Check for working CXX compiler: /usr/bin/c++=20
> -- Check for working CXX compiler: /usr/bin/c++ -- works=20
> -- Detecting CXX compiler ABI info=20
> -- Detecting CXX compiler ABI info - done=20
> -- Detecting CXX compile features=20
> -- Detecting CXX compile features - done=20
> -- Configuring done=20
> -- Generating done=20
> -- Build files have been written to: /home/pi/testes/xenomai/helloWorld=
=20

> But, after this, when I execute "make":=20

> Scanning dependencies of target helloWorld=20
> [ 50%] Building C object CMakeFiles/helloWorld.dir/helloWorld.c.o=20
> In file included from /usr/xenomai/include/copperplate/threadobj.h:28:0,=
=20
> from /usr/xenomai/include/alchemy/task.h:25,=20
> from /home/pi/testes/xenomai/helloWorld/helloWorld.c:5:=20
> /usr/xenomai/include/boilerplate/lock.h:23:34: fatal error:=20
> boilerplate/wrappers.h: file or directory not found=20
> #include <boilerplate/wrappers.h>=20
> ^=20
> compilation terminated.=20
> CMakeFiles/helloWorld.dir/build.make:62: recipe for target=20
> 'CMakeFiles/helloWorld.dir/helloWorld.c.o' failed=20
> make[2]: *** [CMakeFiles/helloWorld.dir/helloWorld.c.o] Error 1=20
> CMakeFiles/Makefile2:67: recipe for target 'CMakeFiles/helloWorld.dir/all=
'=20
> failed=20
> make[1]: *** [CMakeFiles/helloWorld.dir/all] Error 2=20
> Makefile:83: recipe for target 'all' failed=20
> make: *** [all] Error 2=20

> ** cmake_xenomai attempt **=20
> ---------------------=20
> I also tried to use the cmake_xenomai github project:=20
> git clone https://github.com/nolange/cmake_xenomai=20

> But when I check the patch:=20
> git apply --check=20
> /home/pi/cmake_xenomai/patchset/0001-add-an-flexible-bootstrap-template-h=
eader.patch=20

> I got these errors, so I didn't applied it:=20
> error: include/xenomai/Makefile.am: no such file or directory=20
> error: include/xenomai/init.h: no such file or directory=20
> error: lib/boilerplate/init/Makefile.am: no such file or directory=20
> error: lib/boilerplate/init/bootstrap.c: no such file or directory=20

> Evandro Sestrem=20

Regards=20
Per =C3=96berg=20
