Date: Tue, 30 Jan 2007 16:47:21 +0800
From: jserv@domain.hid
Message-ID: <20070130084721.GA19760@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Subject: [Xenomai-core] PATCH: GCC4 build on Xenomai Simulator
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


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hello list,

  Recently, I am building Xenomai Simulator on Ubuntu feisty, and
encounter the following compilation errors:
<%
make[1]: Entering directory `/home/jserv/realtime/xenomai/build-sim/vm'                             
if /bin/sh ../libtool --tag=CXX --mode=compile g++ -DHAVE_CONFIG_H -I.
-I../../sim/vm -I../include  -fno-exceptions -D__XENO_SIM__
-I../../sim/vm/..   -g -MT libmvm_la-thread.lo -MD -MP -MF
".deps/libmvm_la-thread.Tpo" -c -o libmvm_la-thread.lo `test -f
'thread.cc' || echo '../../sim/vm/'`thread.cc; \
        then mv -f ".deps/libmvm_la-thread.Tpo"
".deps/libmvm_la-thread.Plo"; else rm -f ".deps/libmvm_la-thread.Tpo";
exit 1; fi
 g++ -DHAVE_CONFIG_H -I. -I../../sim/vm -I../include -fno-exceptions
-D__XENO_SIM__ -I../../sim/vm/.. -g -MT libmvm_la-thread.lo -MD -MP -MF
.deps/libmvm_la-thread.Tpo -c ../../sim/vm/thread.cc  -fPIC -DPIC -o
.libs/libmvm_la-thread.o
../../sim/vm/thread.cc: In member function 'virtual void
XenoThread::resume()':
../../sim/vm/thread.cc:66: error: 'int MvmThread::globalTrace' is
private
../../sim/vm/thread.cc:1184: error: within this context
../../sim/vm/thread.cc:66: error: 'int MvmThread::globalTrace' is
private
 ...
 %>

$ gcc --version
gcc (GCC) 4.1.2 20070106 (prerelease) (Ubuntu 4.1.1-21ubuntu7)

The patch to fix the above issue is attached. Please take a look at
that. Thanks!

Best Regards,
Jim Huang (jserv)
http://jserv.sayya.org/

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="xeno-sim-gcc4.patch"

Index: sim/vm/thread.cc
===================================================================
--- sim/vm/thread.cc	(revision 2087)
+++ sim/vm/thread.cc	(working copy)
@@ -794,10 +794,12 @@ void MvmThread::bumpInto ()
     do_restore(&context);
 }
 
+#ifdef CONFIG_XENO_MVM_DEBUG
 void MvmThread::setGlobalTrace (int traceLevel) {
 
     globalTrace = traceLevel;
 }
+#endif // CONFIG_XENO_MVM_DEBUG
 
 extern int _etext, _edata, _end;
 
Index: sim/vm/thread.h
===================================================================
--- sim/vm/thread.h	(revision 2087)
+++ sim/vm/thread.h	(working copy)
@@ -120,7 +120,11 @@ private:
 
     virtual void body();
 
+#ifdef CONFIG_XENO_MVM_DEBUG
+public:
     static int globalTrace;
+    static void setGlobalTrace(int traceLevel);
+#endif // CONFIG_XENO_MVM_DEBUG
 
 protected:
 
@@ -138,8 +142,6 @@ public :
 
     static MvmScheduler runChain;
 
-    static void setGlobalTrace(int traceLevel);
-
     MvmThread(const char *name,
 	      int pflags =0,
 	      unsigned stackSize =32768);

--0F1p//8PRICkK4MW--

