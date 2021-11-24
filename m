From: "Godbille, Clement" <Clement.Godbille2@leoni.com>
Subject: Regarding the development of an OOB compatible driver
Date: Wed, 24 Nov 2021 15:16:31 +0000
Message-ID: <AM6PR08MB3416EA59643AC0D3AD2C4155B2619@AM6PR08MB3416.eurprd08.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Mr. Gerum,



Thank you very much for your return. I have a better understanding of how t=
he OOB interruption pipeline is organized.



Thus, I have tried to adapt my UART driver to work correctly during the OOB=
 stage. I handled carefully all the existing locks and unlocks, and I am tr=
ying to adapt all remaining code called by my interruption to an OOB contex=
t. However, I reached kernel methods which are protected by a call to the "=
check_inband_stage" method (for instance, __kmalloc or __wake_up_common).



I understand that I should not touch those methods (I wouldn't dare). But I=
 don't know if there are any OOB compatible to those methods.



The documentation page which could relate to this topic is under constructi=
on (the kernel function index). Do you have other sources of information, m=
ethod or examples on how to deal with this case to make it OOB compliant ?



Thank you for your time and best regards.



Cl=E9ment GODBILLE

Software engineer

Business Unit Robotic Solutions

LEONI CIA Cable Systems S.A.S.

1, Avenue Louis Pasteur

28630 Gellainville

France

RCS Chartres B 330 388 356

TVA : FR 68 330 388 356

President : Peter GERSTENBERGER

General Manager : Claude BURLOT

