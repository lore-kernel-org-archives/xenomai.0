MIME-Version: 1.0
From: Evandro Sestrem <sestrem@gmail.com>
Date: Tue, 4 Dec 2018 09:40:20 -0200
Message-ID: <CADeNpu+DzZU9_eW5fVq2kqRNm8F0N3XVnpfsK2RbM_aj887UfA@mail.gmail.com>
Subject: HelloWorld with CMake
Content-Type: text/plain; charset="UTF-8"
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

Is it possible to use CMake to compile a Xenomai program?

I want to use Xenomai in a ROS 2 node. To do this, I need to be able to
compile it with CMake.

I'm trying to compile a HelloWorld Xenomai program using CMake.

I put this project in https://github.com/sestrem/xenomai_helloworld_cmake

The main files are:
helloWorld.c
CMakeLists.txt

When I execute "cmake .", everything is fine:

-- The C compiler identification is GNU 6.3.0
-- The CXX compiler identification is GNU 6.3.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/pi/testes/xenomai/helloWorld


But, after this, when I execute "make":

Scanning dependencies of target helloWorld
[ 50%] Building C object CMakeFiles/helloWorld.dir/helloWorld.c.o
In file included from /usr/xenomai/include/copperplate/threadobj.h:28:0,
                 from /usr/xenomai/include/alchemy/task.h:25,
                 from /home/pi/testes/xenomai/helloWorld/helloWorld.c:5:
/usr/xenomai/include/boilerplate/lock.h:23:34: fatal error:
boilerplate/wrappers.h: file or directory not found
 #include <boilerplate/wrappers.h>
                                  ^
compilation terminated.
CMakeFiles/helloWorld.dir/build.make:62: recipe for target
'CMakeFiles/helloWorld.dir/helloWorld.c.o' failed
make[2]: *** [CMakeFiles/helloWorld.dir/helloWorld.c.o] Error 1
CMakeFiles/Makefile2:67: recipe for target 'CMakeFiles/helloWorld.dir/all'
failed
make[1]: *** [CMakeFiles/helloWorld.dir/all] Error 2
Makefile:83: recipe for target 'all' failed
make: *** [all] Error 2


** cmake_xenomai attempt **
---------------------
I also tried to use the cmake_xenomai github project:
git clone https://github.com/nolange/cmake_xenomai

But when I check the patch:
git apply --check
/home/pi/cmake_xenomai/patchset/0001-add-an-flexible-bootstrap-template-header.patch

I got these errors, so I didn't applied it:
error: include/xenomai/Makefile.am: no such file or directory
error: include/xenomai/init.h: no such file or directory
error: lib/boilerplate/init/Makefile.am: no such file or directory
error: lib/boilerplate/init/bootstrap.c: no such file or directory


Evandro Sestrem
