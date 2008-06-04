From: Henry Bausley <hbausley@domain.hid>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Jun 2008 14:19:30 -0700
Message-Id: <1212614370.21088.23.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Saving floating point registers inside ISR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


I am converting a 440EP power pc FSM Labs RT-Linux application to a
Xenomai 2.4.2 posix application. Previously we saved the floating point
registers in the ISR.  I had the following code with RTLinux.

//-------------------------------------------------------------------------=
----
int phase_intr(xnintr_t *cookie)
{
  rthal_fpenv_t fpustate;

  rthal_save_fpu(&fpustate);

  phase();

  =EF=BB=BFrthal_restore_fpu(&fpustate);
  return (XN_ISR_HANDLED);
}

with xenomai if we do the the same thing the system hangs.


However if we make the location where we save the registers global, or
declare it static inside the ISR we don't have a problem.  I don't want
to do that since there are cases when the interrupt can be re-entered.
Does anyone have any ideas?

rthal_fpenv_t fpustate;

=EF=BB=BF//----------------------------------------------------------------=
-------------
int phase_intr(xnintr_t *cookie)
{

  rthal_save_fpu(&fpustate);

  phase();

  =EF=BB=BFrthal_restore_fpu(&fpustate);
  return (XN_ISR_HANDLED);
}




