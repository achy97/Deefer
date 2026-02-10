const socket = io();
const status = document.getElementById("status");

socket.on("connect", () => {
  status.innerText = "✅ Connected";
});

socket.on("disconnect", () => {
  status.innerText = "❌ Disconnected";
});

// File send
function sendFile() {
  const file = document.getElementById("fileInput").files[0];
  if (!file) return alert("Select a file");

  const reader = new FileReader();
  reader.onload = () => {
    socket.emit("file", {
      name: file.name,
      data: reader.result
    });
  };
  reader.readAsArrayBuffer(file);
}

// Receive file silently
socket.on("file", (file) => {
  const blob = new Blob([file.data]);
  const a = document.createElement("a");
  a.href = URL.createObjectURL(blob);
  a.download = file.name;
  a.click();
});
