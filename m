MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
Date: Tue, 12 Oct 2010 14:10:20 +0200
Message-ID: <AANLkTi=hTtiyjxUr5FivrSOzjjuNPNF9aUFvjB36gKaL@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: multipart/mixed; boundary=0015175cdfac62d34804926a5cd5
Subject: [Xenomai-core] prepare-kernel.sh --default fails silently if no
	default patch can be found
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0015175cdfac62d34804926a5cd5
Content-Type: text/plain; charset=ISO-8859-1

Hi,

If the prepare-kernel.sh script is executed with the --default option,
but no default patch can be found for the selected linux kernel
version, the script incorrectly tries to continue (and hangs executing
a malformed grep command)

If no default patch can be found, the $adeos_default_patch variable is
set /dev/null. This filename in this variable is later checked for
readability with 'test -r', which succeeds for /dev/null. This causes
the script to continue with an invalid patch, and subsequently hangs
on the following command:

adeos_version=`grep '^#define.*IPIPE_ARCH_STRING.*"' $asm_ipipe_h
2>/dev/null|head -n1|sed -e 's,.*"\(.*\)"$,\1,'`

where
asm_ipipe_h=`ls
$linux_tree/include/asm-{$linux_arch,$xenomai_arch}/ipipe.h
2>/dev/null|head -n1

But since the patch failed, $asm_ipipe_h is also empty, the grep
command translates to:
grep  ^#define.*IPIPE_ARCH_STRING.*"
so grep waits for input since no files are given, and the
prepare-kernel.sh script is effectively blocked (without useful
output).

Please find in attachment a patch that adds a check for /dev/null
instead of simply 'test -r', and adds some output in case no default
patch could be found.

Best regards,
Thomas

--0015175cdfac62d34804926a5cd5
Content-Type: application/octet-stream; 
	name="xenomai-05-improve-output-of-prepare-kernel-script.patch"
Content-Disposition: attachment; 
	filename="xenomai-05-improve-output-of-prepare-kernel-script.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gf6q6iat0

LS0tIHhlbm9tYWktMi41LjQub3JpZy9zY3JpcHRzL3ByZXBhcmUta2VybmVsLnNoCTIwMTAtMDUt
MTggMjA6MzE6MTcuMDAwMDAwMDAwICswMjAwCisrKyB4ZW5vbWFpLTIuNS40L3NjcmlwdHMvcHJl
cGFyZS1rZXJuZWwuc2gJMjAxMC0xMC0xMiAxMzoyMjo0NS4yNTAxNDE3MTUgKzAyMDAKQEAgLTM3
Myw2ICszNzMsOSBAQAogICAgICAgZGVmYXVsdF9hZGVvc19wYXRjaD0iYCggbHMgJHhlbm9tYWlf
cm9vdC9rc3JjL2FyY2gvJHhlbm9tYWlfYXJjaC9wYXRjaGVzL2FkZW9zLWlwaXBlLSRsaW51eF92
ZXJzaW9uKi17JGxpbnV4X2FyY2gsJHhlbm9tYWlfYXJjaH0tKnxzb3J0IC1yICkgMj4vZGV2L251
bGwgfCBoZWFkIC1uMWAiCiAgICBmaQogICAgaWYgdGVzdCB4JGRlZmF1bHRfYWRlb3NfcGF0Y2gg
PSB4OyB0aGVuCisgICAgICBpZiB0ZXN0IHgkdmVyYm9zZSA9IHgxOyB0aGVuCisgICAgICAgICBl
Y2hvICIkbWU6IG5vIGRlZmF1bHQgQWRlb3MgcGF0Y2ggZm91bmQuIiA+JjIKKyAgICAgIGZpCiAg
ICAgICBkZWZhdWx0X2FkZW9zX3BhdGNoPS9kZXYvbnVsbAogICAgZmkKICAgIHdoaWxlIHRlc3Qg
eCRhZGVvc19wYXRjaCA9IHg7IGRvCkBAIC0zODMsNyArMzg2LDcgQEAKICAgICAgIGlmIHRlc3Qg
eCRhZGVvc19wYXRjaCA9IHg7IHRoZW4KICAgICAgICAgIGFkZW9zX3BhdGNoPSRkZWZhdWx0X2Fk
ZW9zX3BhdGNoCiAgICAgICBmaQotICAgICAgaWYgdGVzdCBcISAtciAiJGFkZW9zX3BhdGNoIjsg
dGhlbgorICAgICAgaWYgdGVzdCBcISAtciAiJGFkZW9zX3BhdGNoIiAtbyB4JGFkZW9zX3BhdGNo
ID0geC9kZXYvbnVsbDsgdGhlbgogICAgICAgICAgZWNobyAiJG1lOiBjYW5ub3QgcmVhZCBBZGVv
cyBwYXRjaCBmcm9tICRhZGVvc19wYXRjaCIgPiYyCiAgICAgICAgICB1c2VkZWZhdWx0PQogICAg
ICAgICAgYWRlb3NfcGF0Y2g9Cg==
--0015175cdfac62d34804926a5cd5--

