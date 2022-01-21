From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: About the kernel configuration(CONFIG_CPU_FREQ and
 CONFIG_CPU_IDLE.)
Date: Fri, 21 Jan 2022 03:21:11 +0000
Message-ID: <MN2PR11MB42852029E33D21B057BBECF7F25B9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <CAAvDm6YgEyJuX98RzioWFTrWdY2zGDPGdptLnL9oivVHmsCZsg@mail.gmail.com>
 <CAAvDm6aoKx65CcipLG9t4MgmzKLhzkEtzAX_z23B5VUnw7iTUg@mail.gmail.com>
 <MN2PR11MB42859CE34F2CD706F90946D4F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42857ACE5AA3060BC17341A2F2599@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6aRtpbcjqOuucPfxkGP=KNw+GSfTUfTu8e03=GRz4-qxA@mail.gmail.com>
 <MN2PR11MB42854BE231D5F7080F514DF0F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <MN2PR11MB42850F0D987538BF443EFF98F25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6ZJh_DGF07Pwsi0y8ft4Lw64sSC8kMGA0uBPzaT8h2-3Q@mail.gmail.com>
 <CAAvDm6YCxbErHvjz-pr-u8OO1_hhqxNQ88yhUnF6sYQAXmC=_g@mail.gmail.com>
 <MN2PR11MB4285FCBABC019AC49797554FF25A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAAvDm6akW-cZEdxz-i-qxibHZqyJ+9mV6vqPOa=7noYb2KUSAw@mail.gmail.com>
In-Reply-To: <CAAvDm6akW-cZEdxz-i-qxibHZqyJ+9mV6vqPOa=7noYb2KUSAw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

DQoNCj5Gcm9tOiA/Pz8gc3Vuc2hpbG9uZyA8c3Vuc2hpbG9uZzM2OUBnbWFpbC5jb20+IA0KPlNl
bnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIwLCAyMDIyIDQ6MjYgUE0NCj5UbzogQ2hlbiwgSG9uZ3po
YW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPg0KPkNjOiB4ZW5vbWFpQHhlbm9tYWkub3JnDQo+
U3ViamVjdDogUmU6IEFib3V0IHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbihDT05GSUdfQ1BVX0ZS
RVEgYW5kIENPTkZJR19DUFVfSURMRS4pDQo+DQo+PiBQbGVhc2UgdHJ5IGlmIGNhbiBlbnRlciBp
bnRvICBhZHZhbmNlZC0+cG93ZXIgJiBwZXJmb3JtYW5jZSAtPiBDUFUgLSBQb3dlciBNYW5hZ2Vt
ZW50IENvbnRyb2wNCj4+VGhlcmUgc2hvdWxkIGJlIEMgU3RhdGVzIGl0ZW1zLg0KPg0KPlRoYW5r
IHlvdSBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCj5UaG91Z2ggSSBoYXZlIGNhcmVm
dWxseSBjaGVja2VkIGV2ZXJ5IHN1Ym1lbnUsIGl0J3MgYSBwaXR5IHRoYXQgSSByZWFsbHkgY2Fu
J3QgZmluZCB0aGUgDQo+Qy1zdGF0ZSBpdGVtcyBpbiB0aGUgQklPUy4NCj4NCj5JIHRoaW5rIHRo
aXMgQklPUyBtYXkgZG9lcyBub3Qgc3VwcG9ydCB0byBtYW51YWxseSBkaXNhYmxlIEMtU1RBVEUu
DQo+ICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eDQoNCkkgc3VnZ2VzdCB5b3UgbWF5IHRyeSBSVCBvbiBpbmR1c3RyaWFsIFBDIHdoaWNo
IGV4cG9zZSBtb3JlIG9wdGlvbnMgaW4gYmlvcyB0byBjb250cm9sIHBvd2VyIGFuZCBwZXJmb3Jt
YW5jZSBieSB5b3Vyc2VsZi4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCg0KPg0KPkhl
cmUgYXJlIHRoZSBtZW51cyB0aGF0IEkgY2FuIHNlZS4NCj5NZW51IGZvciBhZHZhbmNlZCwgc2Vl
IGh0dHBzOi8vaWJiLmNvL0NNeU5CNkcNCj5NZW51IGZvciBhZHZhbmNlZC0+b25ib2FyZCBkZXZp
Y2VzLCBzZWUgaHR0cHM6Ly9pYmIuY28vdGN0UDEyNw0KPk1lbnUgZm9yICBwZXJmb3JtYW5jZSZj
b29saW5nLCBzZWUgaHR0cHM6Ly9pYmIuY28vdnZud3pCMQ0KPkFsc28sIHRoZXJlIG5vIHN1Y2gg
bWVudSBpdGVtcyBpbiBtYWluIG1lbnUgaW5kZWVkLg0KPg0K

