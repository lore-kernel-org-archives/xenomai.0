content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83CC5.9F5FD663"
Date: Wed, 12 Dec 2007 14:48:06 +0100
Message-ID: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
From: "DOURNES Guillaume" <Guillaume.DOURNES@lgm.fr>
Subject: [Xenomai-help] CP-118U RTDM Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <'xenomai@xenomai.org'>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83CC5.9F5FD663
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I have a kernel 2.6.20.9 with Xenomai 2.3.4.

I chose a Moxa CP-118U board on my project, to be able to drive this PCI =
board with the xeno_16550A module.

So I tried to drive one port of this board by calling :

=20

modprobe mxser

rmmod mxser

modprobe xeno_16550A ioaddr=3D0xb500 irq=3D5

=20

And I run my simple software of test.

=20

But when the task is started, my computer become very slow, as a process =
eats a lot of CPU load.

This state stay even if I stop the software by CTRL+C, and even if I =
discharge the xeno_16550A module.

Only a reboot allow to go I a good state.

=20

My question is why the CPU become very loaded, whereas my software do =
nothing.

=20

I tried my software with the serial port on my mother board, and with =
this port, the system stay in a good state. It becomes not very slow.

=20

Moreover, I contact Moxa and his response was :

"I am afraid that you cannot use 16550A module to driver CP-118U.

The reason is because we use MU860 but not 16550A in CP118U."

=20

So, Does the CP-118U board work with the xeno_16550A module ??

Else how can I drive the CP-118U board with rtdm ?

=20

Thanks,

=20

Guillaume.

=20

/*********************** test.c *****************************/

#include <stdio.h>

#include <signal.h>

#include <unistd.h>

#include <sys/mman.h>

=20

#include <native/task.h>

#include <native/timer.h>

=20

#include <rtdm/rtserial.h>

=20

#define LOG_PREFIX    "rt_serial_uprog: "

#define RTASK_PREFIX  "read_task : "

=20

#define PORT_0                                   "rtser0"

=20

int timer_started =3D 0;

int my_fd_0 =3D -1;

=20

#define STATE_FILE_OPENED_PORT_0           0x01

#define STATE_FILE_OPENED_PORT_7           0x02

#define STATE_TASK_EVENT_CREATED                     0x04

#define STATE_TASK_READ_CREATED                                   0x08

#define STATE_TASK_WRITE_CREATED                      0x10

=20

unsigned int my_state =3D 0;

RT_TASK read_task;

=20

=20

static int close_file( int fd, unsigned char *name)

{

            int ret,i=3D0;

            do

            {

                        i++;

                        ret =3D rt_dev_close(fd);

                        switch(-ret)

                        {

                                   case EBADF:

                                               printf(LOG_PREFIX "%s -> =
invalid fd or context\n",name);

                                   break;

=20

                                   case EAGAIN:

                                               printf(LOG_PREFIX "%s -> =
EAGAIN (%d times)\n",name,i);

                        rt_task_sleep(50000); // wait 50us

            break;

=20

            case 0:

                        printf(LOG_PREFIX "%s -> closed\n",name);

            break;

=20

            default:

                        printf(LOG_PREFIX "%s -> ???\n",name);

            break;

                        }

            } while (ret =3D=3D -EAGAIN && i < 10);

            return ret;

}

=20

void close_all_file(void)

{

            if (my_state & STATE_FILE_OPENED_PORT_0)

            {

                        close_file( my_fd_0, PORT_0);

                        my_state &=3D ~STATE_FILE_OPENED_PORT_0;

            }

}

=20

void cleanup_all(void)

{

            if (my_state & STATE_FILE_OPENED_PORT_0)

            {

                        close_file( my_fd_0, PORT_0);

                        my_state &=3D ~STATE_FILE_OPENED_PORT_0;

            }

            if (my_state & STATE_TASK_READ_CREATED)

            {

                        printf(LOG_PREFIX "delete read_task\n");

                        rt_task_delete(&read_task);

                        my_state &=3D ~STATE_TASK_READ_CREATED;

            }

}

=20

void catch_signal(int sig)

{

            cleanup_all();

            printf(LOG_PREFIX "exit\n");

            return;

}

=20

void read_task_proc(void *arg)

{

=20

}

=20

int main(int argc, char* argv[])

{

            int ret =3D 0;

            signal(SIGTERM, catch_signal);

            signal(SIGINT, catch_signal);

=20

            printf(LOG_PREFIX "PRESS CTRL-C to EXIT\n");

            /* no memory-swapping for this programm */

            mlockall(MCL_CURRENT | MCL_FUTURE);

=20

            /* open PORT_0 */

            my_fd_0 =3D rt_dev_open( PORT_0, 0);

            if (my_fd_0 < 0)

            {

                        printf(LOG_PREFIX "can't open %s car my_fd =3D =
%d\n", PORT_0, my_fd_0);

                        goto error;

            }

            my_state |=3D STATE_FILE_OPENED_PORT_0;

=20

  /* create read_task */

  ret =3D rt_task_create(&read_task,"read_task",0,51,0);

  if (ret)

  {

            printf(LOG_PREFIX "failed to create read_task, code =
%d\n",ret);

            goto error;

  }

  my_state |=3D STATE_TASK_READ_CREATED;

  printf(LOG_PREFIX "La tache read-task cr=E9=E9e avec succ=E9s\n");

=20

  /* start read_task */

  printf(LOG_PREFIX "Demarrage de la tache read-task\n");

  ret =3D rt_task_start(&read_task,&read_task_proc,NULL);

  if (ret)

  {

            printf(LOG_PREFIX "failed to start read_task, code =
%d\n",ret);

            goto error;

  }

=20

            pause();

=20

  return 0;

=20

error:

            cleanup_all();

            return ret;

}

=20

/********************* End test.c**************************************/

=20


------_=_NextPart_001_01C83CC5.9F5FD663
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Tms Rmn";
	panose-1:2 2 6 3 4 5 5 2 3 4;}
@font-face
	{font-family:Helv;
	panose-1:2 11 6 4 2 2 2 3 2 4;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Times;
	panose-1:2 2 6 3 5 4 5 2 3 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Times New \(W1\)";
	panose-1:2 2 6 3 5 4 5 2 3 4;}
@font-face
	{font-family:"CG Times";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"MS Sans Serif";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"UniversS 45 Light";}
@font-face
	{font-family:"ExtraS 3";}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
h1
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:12.0pt;
	margin-left:35.4pt;
	text-align:justify;
	text-indent:-35.4pt;
	page-break-after:avoid;
	mso-list:l0 level1 lfo4;
	font-size:16.0pt;
	font-family:Arial;
	font-variant:small-caps;}
h2
	{margin-top:9.0pt;
	margin-right:0cm;
	margin-bottom:12.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.4pt;
	page-break-after:avoid;
	mso-list:l0 level2 lfo4;
	font-size:14.0pt;
	font-family:Arial;
	font-variant:small-caps;}
h3
	{margin-top:15.0pt;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level3 lfo4;
	font-size:10.0pt;
	font-family:Times;
	font-variant:small-caps;}
h4
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:92.15pt;
	text-align:justify;
	text-indent:-35.4pt;
	page-break-after:avoid;
	mso-list:l0 level4 lfo4;
	font-size:10.0pt;
	font-family:Times;}
h5
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:177.0pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level5 lfo4;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:normal;}
h6
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:212.4pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level6 lfo4;
	font-size:11.0pt;
	font-family:Times;
	font-weight:normal;
	font-style:italic;}
p.MsoHeading7, li.MsoHeading7, div.MsoHeading7
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:247.8pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level7 lfo4;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoHeading8, li.MsoHeading8, div.MsoHeading8
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:283.2pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level8 lfo4;
	font-size:10.0pt;
	font-family:Arial;
	font-style:italic;}
p.MsoHeading9, li.MsoHeading9, div.MsoHeading9
	{margin-top:12.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:318.6pt;
	text-align:justify;
	text-indent:-35.4pt;
	mso-list:l0 level9 lfo4;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.MsoIndex1, li.MsoIndex1, div.MsoIndex1
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"Courier New";
	font-weight:bold;}
p.MsoIndex2, li.MsoIndex2, div.MsoIndex2
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:24.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex3, li.MsoIndex3, div.MsoIndex3
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex4, li.MsoIndex4, div.MsoIndex4
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:48.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex5, li.MsoIndex5, div.MsoIndex5
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:60.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex6, li.MsoIndex6, div.MsoIndex6
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:72.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex7, li.MsoIndex7, div.MsoIndex7
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:84.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex8, li.MsoIndex8, div.MsoIndex8
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:96.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndex9, li.MsoIndex9, div.MsoIndex9
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:108.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-12.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc1, li.MsoToc1, div.MsoToc1
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.MsoToc2, li.MsoToc2, div.MsoToc2
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:12.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc3, li.MsoToc3, div.MsoToc3
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:24.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc4, li.MsoToc4, div.MsoToc4
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc5, li.MsoToc5, div.MsoToc5
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:48.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc6, li.MsoToc6, div.MsoToc6
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:60.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc7, li.MsoToc7, div.MsoToc7
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:72.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc8, li.MsoToc8, div.MsoToc8
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:84.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoToc9, li.MsoToc9, div.MsoToc9
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:96.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoNormalIndent, li.MsoNormalIndent, div.MsoNormalIndent
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:35.45pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoFootnoteText, li.MsoFootnoteText, div.MsoFootnoteText
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoCommentText, li.MsoCommentText, div.MsoCommentText
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoIndexHeading, li.MsoIndexHeading, div.MsoIndexHeading
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoCaption, li.MsoCaption, div.MsoCaption
	{margin-top:9.0pt;
	margin-right:0cm;
	margin-bottom:12.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.MsoTof, li.MsoTof, div.MsoTof
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:27.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoMacroText, li.MsoMacroText, div.MsoMacroText
	{margin:0cm;
	margin-bottom:.0001pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"UniversS 45 Light";}
p.MsoToaHeading, li.MsoToaHeading, div.MsoToaHeading
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.MsoList, li.MsoList, div.MsoList
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:14.15pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.15pt;
	font-size:11.0pt;
	font-family:Arial;}
p.MsoTitle, li.MsoTitle, div.MsoTitle
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoBodyTextIndent, li.MsoBodyTextIndent, div.MsoBodyTextIndent
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:35.4pt;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoSubtitle, li.MsoSubtitle, div.MsoSubtitle
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:12.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.MsoBodyText2, li.MsoBodyText2, div.MsoBodyText2
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:14.0pt;
	font-family:Arial;
	font-weight:bold;}
p.MsoBodyText3, li.MsoBodyText3, div.MsoBodyText3
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	color:yellow;}
p.MsoBodyTextIndent2, li.MsoBodyTextIndent2, div.MsoBodyTextIndent2
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.MsoBodyTextIndent3, li.MsoBodyTextIndent3, div.MsoBodyTextIndent3
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:9.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-9.0pt;
	font-size:10.0pt;
	font-family:Arial;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoDocumentMap, li.MsoDocumentMap, div.MsoDocumentMap
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	font-size:10.0pt;
	font-family:Tahoma;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:14.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.CommentairesPseudoCode, li.CommentairesPseudoCode, =
div.CommentairesPseudoCode
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Courier New";
	color:green;}
p.DocumentMap1, li.DocumentMap1, div.DocumentMap1
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Tahoma;}
p.etat2, li.etat2, div.etat2
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:3.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Times New \(W1\)";
	text-decoration:underline;}
p.etat3, li.etat3, div.etat3
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:18.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l4 level1 lfo5;
	font-size:10.0pt;
	font-family:"Times New \(W1\)";}
p.font5, li.font5, div.font5
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.item, li.item, div.item
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-27.0pt;
	font-size:10.0pt;
	font-family:Arial;
	color:black;}
p.Listeof, li.Listeof, div.Listeof
	{margin-top:12.0pt;
	margin-right:4.0cm;
	margin-bottom:12.0pt;
	margin-left:4.0cm;
	text-align:center;
	border:none;
	padding:0cm;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.numropage, li.numropage, div.numropage
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"CG Times";}
p.Objetducommentaire1, li.Objetducommentaire1, div.Objetducommentaire1
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.P1, li.P1, div.P1
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.p2, li.p2, div.p2
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:35.45pt;
	font-size:10.0pt;
	font-family:Arial;}
p.Paragraphe, li.Paragraphe, div.Paragraphe
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.PointLGM, li.PointLGM, div.PointLGM
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l1 level1 lfo1;
	font-size:11.0pt;
	font-family:Arial;}
p.R0, li.R0, div.R0
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.R0-rond, li.R0-rond, div.R0-rond
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.R1, li.R1, div.R1
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.R1-carre, li.R1-carre, div.R1-carre
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.R1-rond, li.R1-rond, div.R1-rond
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.R1-tiret, li.R1-tiret, div.R1-tiret
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:31.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-17.0pt;
	mso-list:l2 level1 lfo2;
	font-size:11.0pt;
	font-family:Arial;}
p.R2-carre, li.R2-carre, div.R2-carre
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.R2-rond, li.R2-rond, div.R2-rond
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.R2-tiret, li.R2-tiret, div.R2-tiret
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.R3-tiret, li.R3-tiret, div.R3-tiret
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.25pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.Refexigence, li.Refexigence, div.Refexigence
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	border:none;
	padding:0cm;
	font-size:11.0pt;
	font-family:Arial;}
p.Reference, li.Reference, div.Reference
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l3 level1 lfo3;
	font-size:11.0pt;
	font-family:Arial;}
p.rgle1, li.rgle1, div.rgle1
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.Resume, li.Resume, div.Resume
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.Retraittitre2, li.Retraittitre2, div.Retraittitre2
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:1.0cm;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.T1, li.T1, div.T1
	{margin-top:8.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	text-align:justify;
	line-height:15.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.TabCel, li.TabCel, div.TabCel
	{margin-top:1.0pt;
	margin-right:0cm;
	margin-bottom:1.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.Tableau, li.Tableau, div.Tableau
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:justify;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;}
p.Textedebulles1, li.Textedebulles1, div.Textedebulles1
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.Titretableau, li.Titretableau, div.Titretableau
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:center;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.Titre1-passaut, li.Titre1-passaut, div.Titre1-passaut
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.45pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.xl100, li.xl100, div.xl100
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl101, li.xl101, div.xl101
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl102, li.xl102, div.xl102
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl103, li.xl103, div.xl103
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl104, li.xl104, div.xl104
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl105, li.xl105, div.xl105
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl106, li.xl106, div.xl106
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl107, li.xl107, div.xl107
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl108, li.xl108, div.xl108
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl109, li.xl109, div.xl109
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl110, li.xl110, div.xl110
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl111, li.xl111, div.xl111
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl24, li.xl24, div.xl24
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl25, li.xl25, div.xl25
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl26, li.xl26, div.xl26
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl27, li.xl27, div.xl27
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl28, li.xl28, div.xl28
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl29, li.xl29, div.xl29
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;
	font-weight:bold;}
p.xl30, li.xl30, div.xl30
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl31, li.xl31, div.xl31
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl32, li.xl32, div.xl32
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl33, li.xl33, div.xl33
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl34, li.xl34, div.xl34
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl35, li.xl35, div.xl35
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl36, li.xl36, div.xl36
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl37, li.xl37, div.xl37
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl38, li.xl38, div.xl38
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl39, li.xl39, div.xl39
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl40, li.xl40, div.xl40
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl41, li.xl41, div.xl41
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl42, li.xl42, div.xl42
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl43, li.xl43, div.xl43
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl44, li.xl44, div.xl44
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl45, li.xl45, div.xl45
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl46, li.xl46, div.xl46
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl47, li.xl47, div.xl47
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl48, li.xl48, div.xl48
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl49, li.xl49, div.xl49
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl50, li.xl50, div.xl50
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl51, li.xl51, div.xl51
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl52, li.xl52, div.xl52
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl53, li.xl53, div.xl53
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl54, li.xl54, div.xl54
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl55, li.xl55, div.xl55
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl56, li.xl56, div.xl56
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;
	font-style:italic;}
p.xl57, li.xl57, div.xl57
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl58, li.xl58, div.xl58
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl59, li.xl59, div.xl59
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;
	font-style:italic;}
p.xl60, li.xl60, div.xl60
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.xl61, li.xl61, div.xl61
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl62, li.xl62, div.xl62
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl63, li.xl63, div.xl63
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:6.0pt;
	font-family:Arial;}
p.xl64, li.xl64, div.xl64
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl65, li.xl65, div.xl65
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl66, li.xl66, div.xl66
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl67, li.xl67, div.xl67
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl68, li.xl68, div.xl68
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl69, li.xl69, div.xl69
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:5.0pt;
	font-family:Arial;}
p.xl70, li.xl70, div.xl70
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:5.0pt;
	font-family:Arial;}
p.xl71, li.xl71, div.xl71
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl72, li.xl72, div.xl72
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl73, li.xl73, div.xl73
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:5.0pt;
	font-family:Arial;}
p.xl74, li.xl74, div.xl74
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl75, li.xl75, div.xl75
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl76, li.xl76, div.xl76
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl77, li.xl77, div.xl77
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:"ExtraS 3";}
p.xl78, li.xl78, div.xl78
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.xl79, li.xl79, div.xl79
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl80, li.xl80, div.xl80
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl81, li.xl81, div.xl81
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl82, li.xl82, div.xl82
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl83, li.xl83, div.xl83
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl84, li.xl84, div.xl84
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl85, li.xl85, div.xl85
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl86, li.xl86, div.xl86
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl87, li.xl87, div.xl87
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl88, li.xl88, div.xl88
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl89, li.xl89, div.xl89
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.xl90, li.xl90, div.xl90
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	font-size:9.0pt;
	font-family:Arial;}
p.xl91, li.xl91, div.xl91
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl92, li.xl92, div.xl92
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl93, li.xl93, div.xl93
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:justify;
	font-size:9.0pt;
	font-family:Arial;}
p.xl94, li.xl94, div.xl94
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl95, li.xl95, div.xl95
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl96, li.xl96, div.xl96
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:center;
	background:#FF99CC;
	font-size:9.0pt;
	font-family:Arial;}
p.xl97, li.xl97, div.xl97
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl98, li.xl98, div.xl98
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.xl99, li.xl99, div.xl99
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	text-align:right;
	font-size:9.0pt;
	font-family:Arial;}
p.commentairespseudocode0, li.commentairespseudocode0, =
div.commentairespseudocode0
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Courier New";
	color:green;}
p.documentmap10, li.documentmap10, div.documentmap10
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Tahoma;}
p.listeof0, li.listeof0, div.listeof0
	{margin-top:12.0pt;
	margin-right:4.0cm;
	margin-bottom:12.0pt;
	margin-left:4.0cm;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.numropage0, li.numropage0, div.numropage0
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"CG Times";}
p.objetducommentaire10, li.objetducommentaire10, =
div.objetducommentaire10
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.p10, li.p10, div.p10
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.paragraphe0, li.paragraphe0, div.paragraphe0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.pointlgm0, li.pointlgm0, div.pointlgm0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l1 level1 lfo6;
	font-size:11.0pt;
	font-family:Arial;}
p.r00, li.r00, div.r00
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.r0-rond0, li.r0-rond0, div.r0-rond0
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.r10, li.r10, div.r10
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-carre0, li.r1-carre0, div.r1-carre0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-rond0, li.r1-rond0, div.r1-rond0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-tiret0, li.r1-tiret0, div.r1-tiret0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:31.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-17.0pt;
	mso-list:l2 level1 lfo7;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-carre0, li.r2-carre0, div.r2-carre0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-rond0, li.r2-rond0, div.r2-rond0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-tiret0, li.r2-tiret0, div.r2-tiret0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r3-tiret0, li.r3-tiret0, div.r3-tiret0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.25pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.refexigence0, li.refexigence0, div.refexigence0
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;}
p.reference0, li.reference0, div.reference0
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l3 level1 lfo8;
	font-size:11.0pt;
	font-family:Arial;}
p.rgle10, li.rgle10, div.rgle10
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.resume0, li.resume0, div.resume0
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.retraittitre20, li.retraittitre20, div.retraittitre20
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:1.0cm;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.t10, li.t10, div.t10
	{margin-top:8.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	text-align:justify;
	line-height:15.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.tabcel0, li.tabcel0, div.tabcel0
	{margin-top:1.0pt;
	margin-right:0cm;
	margin-bottom:1.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.tableau0, li.tableau0, div.tableau0
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:justify;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;}
p.textedebulles10, li.textedebulles10, div.textedebulles10
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.titretableau0, li.titretableau0, div.titretableau0
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:center;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.titre1-passaut0, li.titre1-passaut0, div.titre1-passaut0
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.45pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.commentairespseudocode00, li.commentairespseudocode00, =
div.commentairespseudocode00
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Courier New";
	color:green;}
p.documentmap100, li.documentmap100, div.documentmap100
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Tahoma;}
p.listeof00, li.listeof00, div.listeof00
	{margin-top:12.0pt;
	margin-right:4.0cm;
	margin-bottom:12.0pt;
	margin-left:4.0cm;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.numropage00, li.numropage00, div.numropage00
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"CG Times";}
p.objetducommentaire100, li.objetducommentaire100, =
div.objetducommentaire100
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.p100, li.p100, div.p100
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.paragraphe00, li.paragraphe00, div.paragraphe00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.pointlgm00, li.pointlgm00, div.pointlgm00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l1 level1 lfo9;
	font-size:11.0pt;
	font-family:Arial;}
p.r000, li.r000, div.r000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.r0-rond00, li.r0-rond00, div.r0-rond00
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.r100, li.r100, div.r100
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-carre00, li.r1-carre00, div.r1-carre00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-rond00, li.r1-rond00, div.r1-rond00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-tiret00, li.r1-tiret00, div.r1-tiret00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:31.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-17.0pt;
	mso-list:l2 level1 lfo10;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-carre00, li.r2-carre00, div.r2-carre00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-rond00, li.r2-rond00, div.r2-rond00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-tiret00, li.r2-tiret00, div.r2-tiret00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r3-tiret00, li.r3-tiret00, div.r3-tiret00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.25pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.refexigence00, li.refexigence00, div.refexigence00
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;}
p.reference00, li.reference00, div.reference00
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l3 level1 lfo11;
	font-size:11.0pt;
	font-family:Arial;}
p.rgle100, li.rgle100, div.rgle100
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.resume00, li.resume00, div.resume00
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.retraittitre200, li.retraittitre200, div.retraittitre200
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:1.0cm;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.t100, li.t100, div.t100
	{margin-top:8.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	text-align:justify;
	line-height:15.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.tabcel00, li.tabcel00, div.tabcel00
	{margin-top:1.0pt;
	margin-right:0cm;
	margin-bottom:1.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.tableau00, li.tableau00, div.tableau00
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:justify;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;}
p.textedebulles100, li.textedebulles100, div.textedebulles100
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.titretableau00, li.titretableau00, div.titretableau00
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:center;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.titre1-passaut00, li.titre1-passaut00, div.titre1-passaut00
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.45pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.commentairespseudocode000, li.commentairespseudocode000, =
div.commentairespseudocode000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Courier New";
	color:green;}
p.documentmap1000, li.documentmap1000, div.documentmap1000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Tahoma;}
p.listeof000, li.listeof000, div.listeof000
	{margin-top:12.0pt;
	margin-right:4.0cm;
	margin-bottom:12.0pt;
	margin-left:4.0cm;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.numropage000, li.numropage000, div.numropage000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"CG Times";}
p.objetducommentaire1000, li.objetducommentaire1000, =
div.objetducommentaire1000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.p1000, li.p1000, div.p1000
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.paragraphe000, li.paragraphe000, div.paragraphe000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.pointlgm000, li.pointlgm000, div.pointlgm000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l1 level1 lfo12;
	font-size:11.0pt;
	font-family:Arial;}
p.r0000, li.r0000, div.r0000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.r0-rond000, li.r0-rond000, div.r0-rond000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.r1000, li.r1000, div.r1000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-carre000, li.r1-carre000, div.r1-carre000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-rond000, li.r1-rond000, div.r1-rond000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-tiret000, li.r1-tiret000, div.r1-tiret000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:31.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-17.0pt;
	mso-list:l2 level1 lfo13;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-carre000, li.r2-carre000, div.r2-carre000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-rond000, li.r2-rond000, div.r2-rond000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-tiret000, li.r2-tiret000, div.r2-tiret000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r3-tiret000, li.r3-tiret000, div.r3-tiret000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.25pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.refexigence000, li.refexigence000, div.refexigence000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;}
p.reference000, li.reference000, div.reference000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l3 level1 lfo14;
	font-size:11.0pt;
	font-family:Arial;}
p.rgle1000, li.rgle1000, div.rgle1000
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.resume000, li.resume000, div.resume000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.retraittitre2000, li.retraittitre2000, div.retraittitre2000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:1.0cm;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.t1000, li.t1000, div.t1000
	{margin-top:8.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	text-align:justify;
	line-height:15.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.tabcel000, li.tabcel000, div.tabcel000
	{margin-top:1.0pt;
	margin-right:0cm;
	margin-bottom:1.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.tableau000, li.tableau000, div.tableau000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:justify;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;}
p.textedebulles1000, li.textedebulles1000, div.textedebulles1000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.titretableau000, li.titretableau000, div.titretableau000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:center;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.titre1-passaut000, li.titre1-passaut000, div.titre1-passaut000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.45pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.commentairespseudocode0000, li.commentairespseudocode0000, =
div.commentairespseudocode0000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Courier New";
	color:green;}
p.documentmap10000, li.documentmap10000, div.documentmap10000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	background:navy;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Tahoma;}
p.listeof0000, li.listeof0000, div.listeof0000
	{margin-top:12.0pt;
	margin-right:4.0cm;
	margin-bottom:12.0pt;
	margin-left:4.0cm;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;
	font-weight:bold;}
p.numropage0000, li.numropage0000, div.numropage0000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:10.0pt;
	font-family:"CG Times";}
p.objetducommentaire10000, li.objetducommentaire10000, =
div.objetducommentaire10000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.p10000, li.p10000, div.p10000
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.paragraphe0000, li.paragraphe0000, div.paragraphe0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:0cm;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.pointlgm0000, li.pointlgm0000, div.pointlgm0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l1 level1 lfo15;
	font-size:11.0pt;
	font-family:Arial;}
p.r00000, li.r00000, div.r00000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:10.0pt;
	font-family:Arial;}
p.r0-rond0000, li.r0-rond0000, div.r0-rond0000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.r10000, li.r10000, div.r10000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:1.0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-carre0000, li.r1-carre0000, div.r1-carre0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-rond0000, li.r1-rond0000, div.r1-rond0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:42.55pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r1-tiret0000, li.r1-tiret0000, div.r1-tiret0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:31.2pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-17.0pt;
	mso-list:l2 level1 lfo16;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-carre0000, li.r2-carre0000, div.r2-carre0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-rond0000, li.r2-rond0000, div.r2-rond0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	punctuation-wrap:simple;
	text-autospace:none;
	font-size:11.0pt;
	font-family:Arial;}
p.r2-tiret0000, li.r2-tiret0000, div.r2-tiret0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:70.9pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.r3-tiret0000, li.r3-tiret0000, div.r3-tiret0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:99.25pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-indent:-14.2pt;
	font-size:11.0pt;
	font-family:Arial;}
p.refexigence0000, li.refexigence0000, div.refexigence0000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:11.0pt;
	font-family:Arial;}
p.reference0000, li.reference0000, div.reference0000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:64.35pt;
	text-align:justify;
	text-indent:-18.0pt;
	mso-list:l3 level1 lfo17;
	font-size:11.0pt;
	font-family:Arial;}
p.rgle10000, li.rgle10000, div.rgle10000
	{margin-top:6.0pt;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.resume0000, li.resume0000, div.resume0000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;}
p.retraittitre20000, li.retraittitre20000, div.retraittitre20000
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:1.0cm;
	text-align:justify;
	font-size:11.0pt;
	font-family:Arial;}
p.t10000, li.t10000, div.t10000
	{margin-top:8.0pt;
	margin-right:0cm;
	margin-bottom:5.0pt;
	margin-left:0cm;
	text-align:justify;
	line-height:15.0pt;
	font-size:10.0pt;
	font-family:Arial;}
p.tabcel0000, li.tabcel0000, div.tabcel0000
	{margin-top:1.0pt;
	margin-right:0cm;
	margin-bottom:1.0pt;
	margin-left:0cm;
	text-align:center;
	font-size:10.0pt;
	font-family:Arial;}
p.tableau0000, li.tableau0000, div.tableau0000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:justify;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;}
p.textedebulles10000, li.textedebulles10000, div.textedebulles10000
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	font-size:8.0pt;
	font-family:Tahoma;}
p.titretableau0000, li.titretableau0000, div.titretableau0000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:3.0pt;
	margin-left:0cm;
	text-align:center;
	page-break-after:avoid;
	font-size:10.0pt;
	font-family:Arial;
	font-weight:bold;
	font-style:italic;}
p.titre1-passaut0000, li.titre1-passaut0000, div.titre1-passaut0000
	{margin-top:3.0pt;
	margin-right:0cm;
	margin-bottom:6.0pt;
	margin-left:35.45pt;
	text-align:justify;
	text-indent:-35.45pt;
	page-break-after:avoid;
	font-size:14.0pt;
	font-family:Arial;
	text-transform:uppercase;
	font-weight:bold;}
p.section1, li.section1, div.section1
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle299
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle300
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle301
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle302
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle303
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:-5;
	mso-list-template-ids:1910120406;}
@list l0:level1
	{mso-level-style-link:"Titre 1";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:35.4pt;
	text-indent:-35.4pt;}
@list l0:level2
	{mso-level-style-link:"Titre 2";
	mso-level-text:"%1\.%2\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:35.45pt;
	text-indent:-35.4pt;}
@list l0:level3
	{mso-level-style-link:"Titre 3";
	mso-level-text:"%1\.%2\.%3\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:35.45pt;
	text-indent:-35.4pt;}
@list l0:level4
	{mso-level-style-link:"Titre 4";
	mso-level-text:"%1\.%2\.%3\.%4\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:92.15pt;
	text-indent:-35.4pt;}
@list l0:level5
	{mso-level-style-link:"Titre 5";
	mso-level-text:"%1\.%2\.%3\.%4\.%5\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:177.0pt;
	text-indent:-35.4pt;}
@list l0:level6
	{mso-level-style-link:"Titre 6";
	mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:212.4pt;
	text-indent:-35.4pt;}
@list l0:level7
	{mso-level-style-link:"Titre 7";
	mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:247.8pt;
	text-indent:-35.4pt;}
@list l0:level8
	{mso-level-style-link:"Titre 8";
	mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:283.2pt;
	text-indent:-35.4pt;}
@list l0:level9
	{mso-level-style-link:"Titre 9";
	mso-level-text:"%1\.%2\.%3\.%4\.%5\.%6\.%7\.%8\.%9\.";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	mso-level-legacy:yes;
	mso-level-legacy-indent:35.4pt;
	mso-level-legacy-space:0cm;
	margin-left:318.6pt;
	text-indent:-35.4pt;}
@list l1
	{mso-list-id:92557184;
	mso-list-type:hybrid;
	mso-list-template-ids:1303429920 1640688258 67895321 67895323 67895311 =
67895321 67895323 67895311 67895321 67895323;}
@list l1:level1
	{mso-level-style-link:"Point LGM";
	mso-level-text:"\[LGM NOTE -%1 \]";
	mso-level-tab-stop:136.35pt;
	mso-level-number-position:left;
	margin-left:64.35pt;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	mso-ansi-font-weight:bold;
	mso-ansi-font-style:normal;}
@list l1:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2
	{mso-list-id:620839901;
	mso-list-type:hybrid;
	mso-list-template-ids:-2094382190 -1367572412 649201540 -1710319190 =
-1393635428 752093822 -813159200 -126214240 -1236762112 -932564660;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:R1-tiret;
	mso-level-text:\F02D;
	mso-level-tab-stop:32.2pt;
	mso-level-number-position:left;
	margin-left:31.2pt;
	text-indent:-17.0pt;
	mso-ansi-font-size:11.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l2:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3
	{mso-list-id:1336422389;
	mso-list-type:hybrid;
	mso-list-template-ids:2137917902 -1270681664 67895299 67895301 67895297 =
67895299 67895301 67895297 67895299 67895301;}
@list l3:level1
	{mso-level-style-link:Reference;
	mso-level-text:"\[Ref %1\]";
	mso-level-tab-stop:100.35pt;
	mso-level-number-position:left;
	margin-left:64.35pt;
	text-indent:-18.0pt;
	font-family:Arial;
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-font-weight:bold;
	mso-ansi-font-style:normal;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:100.35pt;
	mso-level-number-position:left;
	margin-left:100.35pt;
	text-indent:-18.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:136.35pt;
	mso-level-number-position:left;
	margin-left:136.35pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4
	{mso-list-id:1396471216;
	mso-list-type:simple;
	mso-list-template-ids:613177876;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-style-link:etat3;
	mso-level-text:\F076;
	mso-level-tab-stop:18.0pt;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>I have a kernel 2.6.20.9 with Xenomai =
2.3.4.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>I chose a Moxa CP-118U board on my project, to be able to drive =
this
PCI board with the xeno_16550A module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>So I tried to drive one port of this board by calling =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>modprobe mxser<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>rmmod mxser<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>modprobe xeno_16550A ioaddr=3D0xb500 =
irq=3D5<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>And I run my simple software of =
test.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>But when the task is started, my computer become very slow, as a
process eats a lot of CPU load.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>This state stay even if I stop the software by CTRL+C, and even =
if I
discharge the xeno_16550A module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Only a reboot allow to go I a good =
state.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>My question is why the CPU become very loaded, whereas my =
software do
nothing.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>I tried my software with the serial port on my mother board, and =
with
this port, th<font color=3Dnavy><span =
style=3D'color:navy'>e</span></font> system
stay in a good state. It becomes not very =
slow.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Moreover, I contact Moxa and his response was =
:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&#8220;I am afraid that you cannot use 16550A module to driver =
CP-118U.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>The reason is because we use MU860 but not 16550A in =
CP118U.&#8221;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>So, Does the CP-118U board work with the xeno_16550A module =
??<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Else how can I drive the CP-118U board with rtdm =
?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>Guillaume.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>/*********************** test.c =
*****************************/<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;stdio.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;signal.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;unistd.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;sys/mman.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;native/task.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;native/timer.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#include &lt;rtdm/rtserial.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define LOG_PREFIX&nbsp;&nbsp;&nbsp; &quot;rt_serial_uprog: =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define RTASK_PREFIX&nbsp; &quot;read_task : =
&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define
PORT_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;rtser0&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>int timer_started =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>int my_fd_0 =3D -1;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define =
STATE_FILE_OPENED_PORT_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; 0x01<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define =
STATE_FILE_OPENED_PORT_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; 0x02<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define
STATE_TASK_EVENT_CREATED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x04<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define
STATE_TASK_READ_CREATED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
0x08<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>#define
STATE_TASK_WRITE_CREATED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
0x10<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>unsigned int my_state =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>RT_TASK read_task;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>static int close_file( int fd, unsigned char =
*name)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; int
ret,i=3D0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; do<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

i++;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

ret =3D rt_dev_close(fd);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

switch(-ret)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
case EBADF:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;%s -&gt; invalid fd or =
context\n&quot;,name);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
case EAGAIN:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;%s -&gt; EAGAIN (%d =
times)\n&quot;,name,i);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_task_sleep(50000); // wait 50us<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;break;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; case
0:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;%s -&gt; =
closed\n&quot;,name);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
break;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
default:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;%s -&gt; =
???\n&quot;,name);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
break;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }
while (ret =3D=3D -EAGAIN &amp;&amp; i &lt; =
10);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
return ret;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>void close_all_file(void)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if
(my_state &amp; STATE_FILE_OPENED_PORT_0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

close_file( my_fd_0, PORT_0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

my_state &amp;=3D =
~STATE_FILE_OPENED_PORT_0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>void cleanup_all(void)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if
(my_state &amp; STATE_FILE_OPENED_PORT_0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

close_file( my_fd_0, PORT_0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

my_state &amp;=3D =
~STATE_FILE_OPENED_PORT_0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if
(my_state &amp; STATE_TASK_READ_CREATED)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

printf(LOG_PREFIX &quot;delete =
read_task\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

rt_task_delete(&amp;read_task);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

my_state &amp;=3D ~STATE_TASK_READ_CREATED;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>void catch_signal(int sig)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
cleanup_all();<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
printf(LOG_PREFIX &quot;exit\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
return;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>void read_task_proc(void *arg)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>int main(int argc, char* argv[])<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; int
ret =3D 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
signal(SIGTERM, catch_signal);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
signal(SIGINT, catch_signal);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; printf(LOG_PREFIX
&quot;PRESS CTRL-C to EXIT\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /*
no memory-swapping for this programm */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
mlockall(MCL_CURRENT | MCL_FUTURE);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /*
open PORT_0 */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
my_fd_0 =3D rt_dev_open( PORT_0, 0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if
(my_fd_0 &lt; 0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

printf(LOG_PREFIX &quot;can't open %s car my_fd =3D %d\n&quot;, PORT_0, =
my_fd_0);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=

goto error;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
my_state |=3D STATE_FILE_OPENED_PORT_0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; /* create read_task */<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; ret =3D =
rt_task_create(&amp;read_task,&quot;read_task&quot;,0,51,0);<o:p></o:p></=
span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; if (ret)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;failed to create read_task, code =
%d\n&quot;,ret);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
goto
error;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; my_state |=3D =
STATE_TASK_READ_CREATED;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; </span>printf(LOG_PREFIX &quot;La tache read-task =
cr=E9=E9e avec
succ=E9s\n&quot;);<o:p></o:p></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt'>&nbsp;
</span></font><span lang=3DEN-US>/* start read_task =
*/<o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; printf(LOG_PREFIX &quot;Demarrage de la tache
read-task\n&quot;);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; ret =3D =
rt_task_start(&amp;read_task,&amp;read_task_proc,NULL);<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; if (ret)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; {<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(LOG_PREFIX &quot;failed to start read_task, code =
%d\n&quot;,ret);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
goto
error;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
pause();<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp; return 0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>error:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
cleanup_all();<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;
return ret;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'>/********************* End
test.c**************************************/<o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C83CC5.9F5FD663--

