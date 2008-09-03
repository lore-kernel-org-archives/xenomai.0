Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 3 Sep 2008 11:39:13 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38364@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] native rt_timer questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi!

Why rt_timer functions, esp. rt_timer_tsc(), are not inlined in
user-space=20
(with CONFIG_XENO_HW_DIRECT_TSC) ? Is it because some policy insists=20
that every library function must have an overridable symbol?
Even a branch is worrisome when doing repetitive micro-measurements.
What about a patch along the following? or an extern inline?

--- include/native/timer.h     15 May 2008 07:40:30 -0000
+++ include/native/timer.h     3 Sep 2008 09:10:31 -0000
@@ -46,7 +52,7 @@
 extern "C" {
 #endif
-#if (defined(__KERNEL__)  || defined(__XENO_SIM__)) &&
!defined(DOXYGEN_CPP)
+#if (defined(__KERNEL__)  || defined(__XENO_SIM__) ||
defined(__NATIVE_INLINE)) && !defined(DOXYGEN_CPP)
 static inline SRTIME rt_timer_ns2tsc(SRTIME ns)
 {
        return xnarch_ns_to_tsc(ns);

BTW, I had the bad surprise of rt_timer_read() doing a syscall, which
is costly when doing fine measurement. Should it be documented?


The native rt_timer functions are documented in two locations:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/include_2n
ative_2timer_8h.html
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__nat
ive__timer.html

Could they be gathered, maybe with the here below patch (untested, no
doxy expert):

--- include/native/timer.h     15 May 2008 07:40:30 -0000
+++ include/native/timer.h     3 Sep 2008 09:10:31 -0000
@@ -17,6 +17,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.
+ *
+ * \ingroup native_timer
  */

 #ifndef _XENO_TIMER_H
@@ -26,6 +28,10 @@

 #define TM_ONESHOT XN_APERIODIC_TICK

+/** Structure containing timer-information useful to users.
+ *
+ *  @see rt_timer_inquire()
+ */
 typedef struct rt_timer_info {

     RTIME period;      /* !< Current status (unset, aperiodic, period).
*/

--=20
Stephane

