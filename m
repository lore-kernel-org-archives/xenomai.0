Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5441C03
	for <xenomai@lists.linux.dev>; Tue, 20 Sep 2022 12:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ7g5VX8muN6x9Aq1IDd/jTvu4St08h+vQLjAucafC4QE3NX+JA9G/I17ijpcgriX62dA7aDNgLHqLTKoIJ6x0Ygp01JGrKhPzZGzQEHtNkl6XgruV98WqJcRKQ0fA6l0/iHsErALGcxqXfzVlQSmxbSguufUggx6lwnegUJXqk63W002faoMusG7kPcf/iE8WgF0YjxvnYrwpitg+T4EUb9pMYBXkkCwvS0aHAVvMbtoCx2htvvCPmH7gdlZzXJ6sJDFp1Hr7b5ZQ16U7qgb0RN8QyIGy3H491tyPsxwi8kwGUHNbvdoGVC0QpLEkixRAfKOd7lLTtBRMs94fiV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05rtf1CJuWK/fy4Eyj37HpKblxE68dgDcyZpACYE2Z4=;
 b=cqoQiQwzSavVmCI8ZjqwW2ctIJ5wwKBwgiYAWKp8INho0bs0+yTCVBSrhuHFRHzwCIdQzlHrpO8BAWCQN2hg5cqLxO1ZhmMuKsr7uCRnsagVJ+XVcXt3dGjUauh+VpAJWDjG5RnUcHEqYpyb5k/6PTyZBS63nMG6cFHdprC86GsT1bE1zg4Q0z2tNvK0RDubhTkXqKyMNiBh3N/tNaAhVnPyEZU58fcKWEesP7c0aSWKr5b9Un2ZJRcHIehqF6wijx5WEVmXC/LQztH12fIXhjCE4mJKlaqDh+Vzepk756V1IwgBDunun3/519McoqDsWNUkDXriCfcBFIT29varMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05rtf1CJuWK/fy4Eyj37HpKblxE68dgDcyZpACYE2Z4=;
 b=XzsyoCj2SLMYFB90X3thKEqm8NRuZTckBLZ/1W2m94D008ctPa1D259QtNTIcL+ahgiLHYVdEoSwFSUaC15w9GfZCVJmOW/AGgbJKm4i2iQI39KsmAbsMv9RUE0Q4FAszIhTc5Bgw1GEgQCrkY4K1QAtwO28fVFMYEyJ7pmUMEUaEND218HE1w3EpC13KTotHjNYkQ9SCU3h2sduze9Yl5BCRabeYrS00FAvv8ckL1BJeMjNr+2C5TWpUfprmmSAsdytJvEacO8oH3ySCvVZxtIyZXuyPdzFs0ImVnvjkuaTzSAYA1ZEElAFccpSq6vGRl6PpghSIZaN/zS1NjNURg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:25:10 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%7]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 12:25:10 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the rtcan driver
Date: Tue, 20 Sep 2022 14:25:01 +0200
Message-Id: <20220920122503.115682-3-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920122503.115682-1-florian.bezdeka@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6ce44f-2855-473e-4947-08da9b0328ec
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/0WCxYXbXLV43UQuRjArdL95l/GuH8cgqSxRQmvkCr6pkD+vW1RsjU5vpR6fUX20+9uaeOTBr6g9dpRWupyphylPYtymELxXEndyZUbKuisLwpKFaW11hDDbnVT0ZXfWOQtm8xD+mctgHsuIAKADh9BDVtnDTZt2CjlZsIsHZAqnbVr7PbpXzc9jzggNRerY9poX/NxO3rhOYw3jLeLsShz5LW897lnLSunZ6nptK+BoYfoxr8O993KXaStsIR1DnHWe+xla+247naRGArkl8z5v3sEG0MJ0Hrwn/6WnfQBmulspl9L1PlF1HMHKMFeMdKD6EE62SbYj6BqwESfeKzu6aghFQqCgCR1lOMHsqBQMWxf2Cbrk3g8LULP9YFs/UADhu/mfZW8JJvez/Uti5Ru11KkW/u5kExphoj1Hv6LllSHUzS4PKZqqGgqb3vRp71OtwqQ0j3zMdXFcAyhDPO2nyT53NT1UP+oiADokSaGm2z/rnN9x6vu2yq5gOnhhKbqJSbwpvSAyyKvCL/SW5m2S8OJiifTjwjOzZ5RoMfvx8KpYEfUlx4LWWQMvv/amo9c+4Jl4ojlDVvL+L8A/J/rX7Aw7NmOIj+11DCOvyG26zudzeRdWKk2jkr2hhaz6HIc73r5p0DqkBkkhjFINpvbsB8XTipkgxTN0cpRbUCrWinux3L2qNLZN7xEl4kiE4y3AEgjXiPqPBDKjX8yGCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(2906002)(82960400001)(6486002)(5660300002)(38100700002)(8936002)(478600001)(107886003)(6666004)(6916009)(316002)(86362001)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(6506007)(36756003)(83380400001)(2616005)(44832011)(1076003)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PIr62urWAlsnH8YTdqgN+9qdpJhb3tULyan1Wm7bUBuxYKaHRp1YEa9GhmMM?=
 =?us-ascii?Q?2viOOby8PH7ipH5V9QJWplKo3hM/Rsncmdv9nsnKcryR8Hqncl1YZs3nEpQE?=
 =?us-ascii?Q?a9PdSsaeuC7PKeixL+DvtnuN8OpepsX7M16nfQJzx7nuWJSQ1OWCKXq8wiqI?=
 =?us-ascii?Q?3bFEDhu83G6/MPuwphJ0rKKPe/QpS/hR/ZPhOpPfjk8A8umr7ERaWFTVWQ5e?=
 =?us-ascii?Q?BMBPZwSg44MU8ju8MAArKYhLVoTF59uUucakYzJeJqE/4dCHRR0PTxnFgmQy?=
 =?us-ascii?Q?dkF0b/mAwC+vZ91cC/WJmPUnj+aum8FWBdFtK3pZTQxr7/zenrheFo0xW5Fk?=
 =?us-ascii?Q?jWA6gOufVWlfeqmrKGh0TyYk2Wi2iyxn9YUEOCwZsBwspqdkrxGGn03r/OEF?=
 =?us-ascii?Q?L4kLz3Zj0OO7NGXIy8eaDlQ+mhuBkq5SfVXXZpC2SCmtC+oMVgYRks2z3YTB?=
 =?us-ascii?Q?lQJW+gqX9Wtsxh2gsu500IziDSHPdtobz39PWl+LzG4gywtJtraEwTHeLPWq?=
 =?us-ascii?Q?LeD/g+TEscNqsgawwaszT8SMN1BgD9tZ+Djl/r9d/q+/Fg0wHB3fOP9zXfZl?=
 =?us-ascii?Q?qUz7FP56eIafp9/Z1PBAj3qwRZLIy+ijxC3iyMVHQtdEi3unyxWqbyIoFzqb?=
 =?us-ascii?Q?+0LVCae20UtbzkRrChx2PTwBLdwL5Ns/S82DE6vko1qZqmP2XSXDOwXhkDJd?=
 =?us-ascii?Q?My0ozv/i4hLbmC2tByW2IonYHEY8VB362fSMtbfaVcUnyS0o4Mc0WVTCamEf?=
 =?us-ascii?Q?BxnYfp2JQ2QpQU0Jfy32UBQeZn8KwsDv8DnhmAD19eqPRf9XOOiKRg2kLFA3?=
 =?us-ascii?Q?KaAhPHm4bwEa3TyWAp7hL3rapPxU+EW+azJrzbFPcZzbFHix1B/jXC5myqqY?=
 =?us-ascii?Q?Ej3uHa+kJqK/rGAmhxQK9K4KS1ap0xvWQzID9CWQsEUosR+TcdLIe8ADctKC?=
 =?us-ascii?Q?P4NkMgNknjrYBA6dqrOhQ+zrYVjGmpNt+ZLjtlm7ySTWZC0NhUHNqeq7dhAK?=
 =?us-ascii?Q?mlAmTEzlWopVnH3GXoDV19YP7BybV0ipbTc7M8Q4YC6hh90Lmt9S9atqcIOr?=
 =?us-ascii?Q?Sz7MhPserclxxWdMgWKTD6/Q0LDXviDn+NRKLxkDDC5q0YTAufSCOyAYwz5E?=
 =?us-ascii?Q?Y0cr2Lkn+kFdFPk6pgy6746pfMnWSTCeRFR6veubpqRPGTpsvryl2KY8SG+3?=
 =?us-ascii?Q?HanVzzesXn2CemCOgHxkciPAOQUPF3WWxSgvZCh0E4+BTbHJF8zv0Ev0M0za?=
 =?us-ascii?Q?Jk8hfU48wz+aAvwzWjeBjRIuxozS02BR6ET1aQPji3TbAedYkOZRPPNIWkns?=
 =?us-ascii?Q?P1IpsZfOr57levqpKr/74WmbvHjkriQnwKJ982lp3cvaVL6uBtidqnM5i0oI?=
 =?us-ascii?Q?JPKHt8gJyimE0dARcp3gpoWdmWNcMkQ/578esQme7FSdiOjLoJ1ZYarPKH28?=
 =?us-ascii?Q?xNb3z+mU3vSrWwAllhR3GegRoQmBdEx6/AOSF3p5QLhhlnP1u/7QYKs3Ub3d?=
 =?us-ascii?Q?cI7CP7WnpEcRO3BHv8Q2civ0EGkIVdYsHu5Uj28gUY+ehVQq33smeg9yjWMq?=
 =?us-ascii?Q?/rc/mkq7O7LAO+28SepmDtoIuuGNMYXsc3JSe9p9D1C4ziFvbsB3N4S5FF2o?=
 =?us-ascii?Q?dFKElWQgl/UTDT+FKSag/ZPhwtTi0pyH2k+EstfhHlhuuU4FUAAQ4VOtDD/7?=
 =?us-ascii?Q?Q06kcA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6ce44f-2855-473e-4947-08da9b0328ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:25:10.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBYHXCXmWExPm++HHYvToDW1O/JOC5eZxkAMIMYAkt389s8TLXTb3oy7Lwk9/SsKAsTjePz2WO+HUayQbxBIfhBt+kWx/V4MnkAbiWLV5h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611

Once Xenomai was running as compat application (=32bit applicaiton over
64bit kernel) the can smokey test failed. This patch fixes the test by
implementing the necessary compat bits.

Affected ioctls:
  - _RTIOC_BIND
  - _RTIOC_SETSOCKOPT

Affected syscalls:
  - recvmsg
  - sendmsg

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/can/rtcan_raw.c | 42 ++++++++++++++--------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index dffc6e837..92b7617fb 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -41,6 +41,7 @@
 #include <rtdm/driver.h>
 
 #include <rtdm/can.h>
+#include <rtdm/compat.h>
 #include "rtcan_version.h"
 #include "rtcan_socket.h"
 #include "rtcan_list.h"
@@ -411,17 +412,15 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
     int ret = 0;
 
     switch (request) {
-    case _RTIOC_BIND: {
+    COMPAT_CASE(_RTIOC_BIND): {
+
 	struct _rtdm_setsockaddr_args *setaddr, setaddr_buf;
 	struct sockaddr_can *sockaddr, sockaddr_buf;
 
 	if (rtdm_fd_is_user(fd)) {
-	    /* Copy argument structure from userspace */
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct _rtdm_setsockaddr_args)) ||
-		rtdm_copy_from_user(fd, &setaddr_buf, arg,
-				    sizeof(struct _rtdm_setsockaddr_args)))
-		return -EFAULT;
+	    ret = rtdm_fd_get_setsockaddr_args(fd, &setaddr_buf, arg);
+	    if (ret)
+		return ret;
 
 	    setaddr = &setaddr_buf;
 
@@ -447,16 +446,14 @@ int rtcan_raw_ioctl(struct rtdm_fd *fd,
 	break;
     }
 
-    case _RTIOC_SETSOCKOPT: {
+    COMPAT_CASE(_RTIOC_SETSOCKOPT): {
 	struct _rtdm_setsockopt_args *setopt;
 	struct _rtdm_setsockopt_args setopt_buf;
 
 	if (rtdm_fd_is_user(fd)) {
-	    if (!rtdm_read_user_ok(fd, arg,
-				   sizeof(struct _rtdm_setsockopt_args)) ||
-		rtdm_copy_from_user(fd, &setopt_buf, arg,
-				    sizeof(struct _rtdm_setsockopt_args)))
-		return -EFAULT;
+	    ret = rtdm_fd_get_setsockopt_args(fd, &setopt_buf, arg);
+	    if (ret)
+		    return ret;
 
 	    setopt = &setopt_buf;
 	} else
@@ -575,11 +572,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
 
     if (rtdm_fd_is_user(fd)) {
 	/* Copy IO vector from userspace */
-	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
-			     sizeof(struct iovec)) ||
-	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
-				sizeof(struct iovec)))
-	    return -EFAULT;
+	ret = rtdm_fd_get_iovec(fd, &iov_buf, msg, true);
+	if (ret)
+		return -EFAULT;
 
 	iov = &iov_buf;
     }
@@ -716,9 +711,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
 	iov->iov_base += sizeof(can_frame_t);
 	iov->iov_len -= sizeof(can_frame_t);
 	/* ... and copy it, too. */
-	if (rtdm_copy_to_user(fd, msg->msg_iov, iov,
-			      sizeof(struct iovec)))
-	    return -EFAULT;
+	ret = rtdm_fd_put_iovec(fd, iov, msg);
+	if (ret)
+		return -EFAULT;
 
 	/* Copy timestamp if existent and wanted */
 	if (msg->msg_controllen) {
@@ -922,10 +917,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
     if (rtdm_fd_is_user(fd)) {
 
 	/* Copy IO vector from userspace */
-	if (!rtdm_rw_user_ok(fd, msg->msg_iov,
-			     sizeof(struct iovec)) ||
-	    rtdm_copy_from_user(fd, &iov_buf, msg->msg_iov,
-				sizeof(struct iovec))) {
+	if (rtdm_fd_get_iovec(fd, &iov_buf, msg, false)) {
 	    ret = -EFAULT;
 	    goto finally;
 	}
-- 
2.37.3

