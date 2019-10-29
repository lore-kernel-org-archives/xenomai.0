From: Lange Norbert <norbert.lange@andritz.com>
Subject: binding to iddp socket often blocks forever
Date: Tue, 29 Oct 2019 16:31:57 +0000
Message-ID: <DB8PR05MB5915DE0FD6015A0252EFEBE8F6610@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I have some problems with Xenomai 3.1rc2, the following function will often=
 block after printing "b".
This does not happen always and never happens when I run the program throug=
h gdb, and I can't attach
with gdb if its blocked.
Using another port then -1 makes no difference, and there is a single XDDP =
connection active at the time
(on port #0), but this should be the first and only IDDP socket open.

static int s_bindRtIpcEndpoint(int protocol, czstring pLabel, const int *pA=
rgs, int *pErrno)
{
    int ret;
    int __attribute__((cleanup(auto_closesocket_rt))) fd =3D  __RT(socket)(=
AF_RTIPC, SOCK_DGRAM, protocol);
    TEST_LOG_ERRNO_ERROR_M_SCOPE(fd < 0, *pErrno, "socket", -1);
    printf("a\n");
    if (protocol =3D=3D IPCPROTO_BUFP) {
        size_t bufsz =3D 32768; /* bytes */
        if (pArgs)
            bufsz =3D *pArgs;
        ret =3D setsockopt(fd, SOL_BUFP, BUFP_BUFSZ, &bufsz, sizeof(bufsz))=
;
        TEST_LOG_ERRNO_ERROR_M_SCOPE(ret !=3D 0, *pErrno, "setsockopt", -1)=
;
    }

    if (pLabel)
        setLabel(fd, protocol, pLabel);

    printf("b\n");
    // bind first endpoint
    struct sockaddr_ipc saddr =3D {AF_RTIPC, -1};

    ret =3D __RT(bind)(fd, (struct sockaddr *)&saddr, sizeof(saddr));
    printf("c\n");
    TEST_LOG_ERRNO_ERROR_M_SCOPE(ret !=3D 0, *pErrno, "bind", -1);
    ret =3D fd;
    fd =3D -1; // NOLINT(clang-analyzer-deadcode.DeadStores)
    return ret;
}

The function is called like this:

int tmp;
s_bindRtIpcEndpoint(IPCPROTO_IDDP, NULL, NULL, &tmp);

I really don't know how to tackle this, any hints?

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com
andritz.com

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

